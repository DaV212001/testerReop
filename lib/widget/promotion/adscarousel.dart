import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:mss_e_learning/model/promotion.dart';

import '../../screen/home/home_screen.dart';
import '../../util/screen_util.dart';
import '../cached_image.dart';

class AdsCarousel extends StatefulWidget {
  final List<Promotion> promotion;
  const AdsCarousel({super.key, required this.promotion});

  @override
  State<AdsCarousel> createState() => _AdsCarouselState();
}

class _AdsCarouselState extends State<AdsCarousel> {
  bool? fetched;
  @override
  void initState() {
    //fetchImages();;
    super.initState;
  }

  // List<PhotosModel> images = [];

  List imageList = [
    {"id": 1, "image_path": 'assets/images/photo_1.jpg'},
    {"id": 2, "image_path": 'assets/images/photo_2.jpg'},
    {"id": 3, "image_path": 'assets/images/photo_3.jpg'}
  ];

  final CarouselController carouselController = CarouselController();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final bool isTablet = ScreenUtils.isTablet(context);

    FlutterFlowTheme theme = FlutterFlowTheme.of(context);
    return Obx(()=>Container(
      color: theme.primaryBackground,
      child: Column(children: [
        Stack(
          children: [
            if (widget.promotion.isEmpty)
              Center(
                child: Image.asset(
                  "assets/icon/icon.png",
                  height: 200,
                ),
              ),
            if (widget.promotion.isNotEmpty)
              CarouselSlider(

                items: widget.promotion.map((promotion) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                width: double.infinity,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(30),
                                  child: CachedImage(
                                    url: promotion.image!,
                                    fit: BoxFit.fill,
                                    fromCarousel: true,
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Container(
                                  height: 40,
                                  decoration: const BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.center,
                                      colors: [
                                        Colors.transparent,
                                        Colors.transparent, // Transparent black
                                      ],
                                    ),
                                  ),
                                  width: MediaQuery.of(context).size.width,
                                  child: const SizedBox(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
                carouselController: carouselController,
                options: CarouselOptions(
                  scrollPhysics: const BouncingScrollPhysics(),
                  autoPlay: true,
                  height: MediaQuery.of(context).size.height * 0.27,
                  viewportFraction: 1,
                  onPageChanged: (index, reason) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                ),
              ),
            Positioned(
                bottom: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.only(right: 17, top: 17),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: widget.promotion.asMap().entries.map((entry) {
                              return GestureDetector(
                                onTap: () =>
                                    carouselController.animateToPage(entry.key),
                                child: Container(
                                  width: currentIndex == entry.key ? 17 : 7,
                                  height: 7.0,
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 3.0,
                                  ),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: currentIndex == entry.key
                                          ? theme.secondary
                                          : theme.primaryBackground),
                                ),
                              );
                            }).toList(),
                          ),


                        ],
                      )
                    ],
                  ),
                )),

          ],
        ),

      ]),
    ));
  }
}
