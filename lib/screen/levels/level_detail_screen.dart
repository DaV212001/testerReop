import 'package:flutter/material.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mss_e_learning/controller/level_controller.dart';
import 'package:mss_e_learning/layout/lesson/lesson_details.dart';
import 'package:mss_e_learning/widget/cached_image.dart';
import '../../layout/password/header_image_and_text.dart';
import '../../model/level.dart';
import '../../service/ads_service.dart';
import '../../util/app_constants.dart';
import '../../widget/ad_block.dart';
import '../quiz/quiz_screen.dart';

class LevelDetailScreen extends StatefulWidget {
  final Level level;
  final String image;
  const LevelDetailScreen(
      {super.key, required this.level, required this.image});

  @override
  State<LevelDetailScreen> createState() => _LevelDetailScreenState();
}

class _LevelDetailScreenState extends State<LevelDetailScreen> {
  LevelController levelController = Get.put(LevelController());

  List<BannerAd> bannerAds = [];
  @override
  void initState() {
    loadAd();
    super.initState();
  }

  void loadAd() async {
    bannerAds = await AdsService().loadBannerAds(count: 3);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    bool allLessonsOpened = levelController.allLessonsOpened(widget.level);

    return Scaffold(
      body: Column(mainAxisSize: MainAxisSize.max, children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.3,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: Image.network(
                          widget.image,
                          loadingBuilder: (context, child, loadingProgress) {
                            return Center(
                              child: Container(
                                  color: Colors.white,
                                  child: const Center(
                                      child: Icon(
                                    Icons.play_lesson_outlined,
                                    color: AppConstants.primary,
                                  ))),
                            );
                          },
                          errorBuilder: (context, url, error) => const Icon(
                              Icons.play_lesson_outlined,
                              color: AppConstants.primary),
                        ).image,
                      ),
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 2,
                          color: Color(0x17202529),
                          offset: Offset(0, 1),
                        )
                      ],
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(0),
                        topLeft: Radius.circular(0),
                        topRight: Radius.circular(0),
                      ),
                    ),
                    child: Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(16, 36, 16, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  FlutterFlowIconButton(
                                    borderColor: Colors.transparent,
                                    borderRadius: 30,
                                    borderWidth: 1,
                                    buttonSize: 40,
                                    fillColor: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    icon: Icon(
                                      Icons.arrow_back_ios_rounded,
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      size: 20,
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(15),
                                    topLeft: Radius.circular(15)),
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 0,
                                    color: Colors.black.withOpacity(0.4),
                                  )
                                ]),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                widget.level.name,
                                style: FlutterFlowTheme.of(context)
                                    .headlineMedium
                                    .override(
                                        fontFamily: 'Poppins',
                                        color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (bannerAds.isNotEmpty)
                    AdBlock(bannerAd: bannerAds[0], isbottom: false),
                  widget.level.lessons.isEmpty
                      ? Center(
                          child: HeaderImageAndText(
                          showbackButton: false,
                          imagePath:
                              'assets/images/illustrations/no_certificates.svg',
                          headerText: 'No certificates yet',
                          color: FlutterFlowTheme.of(context).primaryText,
                        ))
                      : Flexible(
                          fit: FlexFit.loose,
                          child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              physics: const BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: widget.level.lessons.length,
                              itemBuilder: (context, index1) {
                                int lessonId = widget.level.lessons[index1].id;
                                String lessonTitle =
                                    widget.level.lessons[index1].title;

                                // Check if the lesson is opened
                                bool isLessonOpened = levelController.checkIfOpened(lessonId);

                                return Column(
                                  children: [
                                    ListTile(
                                      title: Text(lessonTitle),
                                      onTap: () {
                                        // Add the lesson to the list of opened lessons
                                        levelController
                                            .addOpenedLesson(lessonId);
                                        setState(() {
                                          isLessonOpened = true;
                                        });
                                        Get.to(() => LessonDetailScreen(
                                            lessonId: lessonId));
                                      },
                                      // Customize appearance based on whether the lesson is opened
                                      leading: Container(
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(18),
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(18),
                                          child: CachedImage(
                                            url: widget
                                                .level.lessons[index1].image,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                      trailing: Container(
                                          width: 20,
                                          height: 20,
                                          decoration: BoxDecoration(
                                              color: isLessonOpened
                                                  ? FlutterFlowTheme.of(context)
                                                      .primary
                                                  : Colors.grey,
                                              shape: BoxShape.circle)),
                                    ),
                                    const Divider()
                                  ],
                                );
                              }),
                        ),
                  if (bannerAds.isNotEmpty)
                    AdBlock(bannerAd: bannerAds[1], isbottom: false),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FFButtonWidget(
                      text: 'Take Quiz',
                      onPressed: () {
                        if (allLessonsOpened) {
                          Get.to(() => QuizScreen(
                                subcatID: AppConstants.subcatid.toString(),
                                levelId: widget.level.id.toString(),
                              ));
                        } else {
                          Get.snackbar(
                              'Error', 'Please complete all lessons first',
                              backgroundColor: Colors.red);
                        }
                      },
                      options: FFButtonOptions(
                        width: double.infinity,
                        color: allLessonsOpened
                            ? AppConstants.primary
                            : Colors.grey,
                      ),
                    ),
                  ),
                  if (bannerAds.isNotEmpty)
                    AdBlock(bannerAd: bannerAds[2], isbottom: true),
                ]),
          ),
        ),
      ]),
    );
  }
}
