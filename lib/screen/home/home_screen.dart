import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_expanded_tile/flutter_expanded_tile.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mss_e_learning/controller/category_controller.dart';
import 'package:mss_e_learning/controller/ad_controller.dart';
import 'package:mss_e_learning/service/ads_service.dart';
import 'package:mss_e_learning/service/authorization_service.dart';
import 'package:mss_e_learning/util/ad_unit_ids.dart';
import 'package:mss_e_learning/util/api_call_status.dart';
import 'package:mss_e_learning/widget/ad_block.dart';
import 'package:mss_e_learning/widget/cached_image.dart';
import 'package:mss_e_learning/widget/error_card.dart';
import 'package:flutter/animation.dart';
import 'package:mss_e_learning/widget/promotion/adscarousel.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import '../../controller/user_controller.dart';
import '../../layout/home/category_section.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../model/user.dart';
import '../../util/app_constants.dart';
import '../../widget/home/head.dart';
import '../levels/level_detail_screen.dart';
import '../search/search_screen.dart';
import '../subcategory/sub_category_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController search = TextEditingController();

  AdController adController = Get.put(AdController());

  List<BannerAd> bannerAds = [];
  @override
  void initState() {
    loadAd();
    showAppOpenAd();

    super.initState();
  }

  void loadAd() async {
    bannerAds = await AdsService().loadBannerAds(count: 3);
    setState((){});
  }

  AppOpenAd? appOpenAd;
  void showAppOpenAd() async {
    await AdsService().showInterstitialAd();
  }

  @override
  Widget build(BuildContext context) {

    CategoryController controller = Get.put(CategoryController(), tag: 'Category');
    UserController uController = Get.find(tag: 'User');

    return Scaffold(
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: Obx(
        () => controller.status.value == ApiCallStatus.loading
            ? const Padding(
                padding: EdgeInsets.all(50.0),
                child: Center(child: CircularProgressIndicator(color: AppConstants.primary,)),
              )
            : controller.status.value == ApiCallStatus.error
                ? ErrorCard(
                    errorData: controller.errorData.value,
                    refresh: () async {
                      controller.getCategories();
                      String? token = await AuthService.getAuthorizationToken();
                      if(token != null) {
                        await uController.fetchUser(token);
                      }
                    } ,
                  )
                : SafeArea(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if(bannerAds.isNotEmpty) AdBlock(bannerAd: bannerAds[0], isbottom: false),
                                const Padding(
                                  padding: EdgeInsets.only(top: 18.0),
                                  child: HomeScreenHeader(),
                                ),
                                // if(testController.test.value) Container(
                                //   height: 50,
                                //   width: 50,
                                //   decoration: BoxDecoration(
                                //     color: AppConstants.primary,
                                //   ),
                                // ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                                  child: CategoryHorizontalList(controller: controller),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: AdsCarousel(
                                      promotion: controller.listOfPromotions),
                                ),
                                if(bannerAds.isNotEmpty) AdBlock(bannerAd: bannerAds[1], isbottom: false),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Lessons',
                                    style: FlutterFlowTheme.of(context)
                                        .headlineSmall
                                        .override(
                                          fontFamily: 'Poppins',
                                        ),
                                  ),
                                ),
                                SubCatGrid(listOfLessons: controller.getAlllessons(),),
                                if(bannerAds.isNotEmpty) AdBlock(bannerAd: bannerAds[2], isbottom: true),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
      ),
    );
  }
}




class CategoryHorizontalList extends StatelessWidget {
  const CategoryHorizontalList({
    super.key,
    required this.controller,
  });

  final CategoryController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(()=>
        controller.subCategory.levels==null? const SizedBox():
        SizedBox(
      height: MediaQuery.of(context).size.height *0.17,
      child: ListView.builder(
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: controller.subCategory.levels?.length,
          itemBuilder: (context, iindex) {
            return GestureDetector(
              onTap: (){
                pushNewScreen(context,
                    screen: LevelDetailScreen(
                      level: controller.subCategory.levels![iindex],
                      image: controller.subCategory.image!,
                    ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Column(
                  children: [
                    Container(
                      height:  MediaQuery.of(context).size.height *0.1,
                      width: MediaQuery.of(context).size.height *0.1,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CachedImage(
                              url: controller.subCategory.image??'',
                              fit: BoxFit.cover
                          )
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.height *0.1,
                        child: Text(
                            controller.subCategory.levels![iindex].name,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: FlutterFlowTheme.of(context).bodySmall.override(
                              fontFamily: 'Poppins',
                            )
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
    ));
  }
}
