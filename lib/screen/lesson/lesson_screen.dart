import 'package:accordion/accordion.dart';
import 'package:accordion/accordion_section.dart';
import 'package:accordion/controllers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_expanded_tile/flutter_expanded_tile.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:get/get.dart';
import 'package:mss_e_learning/util/api_call_status.dart';
import 'package:mss_e_learning/widget/cached_image.dart';
import 'package:mss_e_learning/widget/error_card.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

import '../../controller/lesson_controllers.dart';
import '../../controller/user_controller.dart';
import '../../layout/lesson/lesson_details.dart';
import '../quiz/quiz_screen.dart';

class SubCategoryDetailScreen extends StatefulWidget {
  final int subCategoryId;
  final String subCategoryImage;
  final String courseName;
  const SubCategoryDetailScreen({super.key, required this.subCategoryId, required this.subCategoryImage, required this.courseName});

  @override
  State<SubCategoryDetailScreen> createState() => _SubCategoryDetailScreenState();
}

class _SubCategoryDetailScreenState extends State<SubCategoryDetailScreen> {



  @override
  Widget build(BuildContext context) {
    final FlutterFlowTheme theme = FlutterFlowTheme.of(context);

    LessonController controller = Get.put(LessonController(subcategoryId: widget.subCategoryId.toString()));
    return Scaffold(
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,

        body: Obx(() => controller.status.value == ApiCallStatus.loading
            ? const Padding(
          padding: EdgeInsets.all(50.0),
          child: Center(child: CircularProgressIndicator()),
        )
            : controller.status.value == ApiCallStatus.error
            ? ErrorCard(
          errorData: controller.errorData.value,
          refresh: () => controller
              .getLevels(controller.subCategoryId.value),
        )
            : buildScreen(context)));
  }

  Widget buildScreen(
      BuildContext context,
      ) {
    final FlutterFlowTheme theme = FlutterFlowTheme.of(context);

    LessonController controller = Get.find();
    return RefreshIndicator(
        color: Theme.of(context).primaryColor,
        displacement: 100,
        onRefresh: () => controller.getLevels(controller.subCategoryId.value),
        child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
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
                              widget.subCategoryImage,
                              loadingBuilder: (context, child, loadingProgress) {
                                return Center(
                                  child: Container(
                                      color: Colors.white,
                                      child:Center(child: Icon(Icons.play_lesson_outlined, color: FlutterFlowTheme.of(context).primary,))
                                  ),
                                );
                              },
                              errorBuilder:  (context, url, error) => Icon(Icons.play_lesson_outlined, color: FlutterFlowTheme.of(context).primary),
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
                          padding: const EdgeInsetsDirectional.fromSTEB(16, 36, 16, 0),
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
                                        fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                                        icon: Icon(
                                          Icons.arrow_back_ios_rounded,
                                          color: FlutterFlowTheme.of(context).primaryText,
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
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(15),
                                        topLeft: Radius.circular(15)),

                                    boxShadow: [BoxShadow(
                                      blurRadius: 0,
                                      color: Colors.black.withOpacity(0.4),
                                    )]
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    widget.courseName,
                                    style: FlutterFlowTheme.of(context).headlineMedium.override(
                                        fontFamily: 'Poppins',
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      Flexible(
                        fit: FlexFit.loose,
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: controller.listOfAllLevels.length,
                          itemBuilder: (context, index1) {
                            return Accordion(
                              disableScrolling: true,
                              flipRightIconIfOpen: true,
                              headerBorderColor: Colors.blueGrey,
                              headerBorderColorOpened: Colors.transparent,
                              headerBorderWidth: 1,
                              headerBackgroundColorOpened: theme.primary,
                              contentBackgroundColor: theme.primary,
                              contentBorderColor: theme.primary,
                              contentVerticalPadding: 0,
                              contentBorderWidth: 3,
                              contentHorizontalPadding: 10,
                              scaleWhenAnimating: true,
                              openAndCloseAnimation: true,
                              paddingListTop: 1,
                              paddingListBottom: 1,
                              headerPadding:
                              const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                              sectionOpeningHapticFeedback: SectionHapticFeedback.heavy,
                              sectionClosingHapticFeedback: SectionHapticFeedback.light,
                              children: [
                                AccordionSection(
                                  isOpen: false,
                                  leftIcon: Icon(Icons.circle, color: theme.primary),
                                  headerBackgroundColor: theme.primary.withOpacity(0.2),
                                  headerBackgroundColorOpened:
                                  theme.primary.withOpacity(0.15),
                                  headerBorderColorOpened: theme.primary,
                                  contentBackgroundColor: FlutterFlowTheme.of(context).primaryBackground,
                                  contentBorderColor: theme.primary.withOpacity(0.3),
                                  headerBorderWidth: 1,
                                  contentBorderWidth: 1,
                                  contentVerticalPadding: 5,
                                  header: Text(controller.listOfAllLevels[index1].name,
                                      style:
                                      TextStyle(fontSize: 18, color: theme.primaryText)),
                                  content: ListView.builder(
                                      itemCount:
                                      controller.listOfAllLevels[index1].lessons.length,
                                      scrollDirection: Axis.vertical,
                                      physics: const BouncingScrollPhysics(),
                                      shrinkWrap: true,
                                      itemBuilder: (context, index2) {
                                        return Column(
                                          children: [
                                            InkWell(
                                                customBorder: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                                splashColor: theme.primary,
                                                highlightColor: Colors.white,
                                                child: ListTile(
                                                    onTap: () {
                                                      pushNewScreen(context,
                                                          screen: LessonDetailScreen(
                                                              lessonId: controller
                                                                  .listOfAllLevels[index1]
                                                                  .lessons[index2]
                                                                  .id));
                                                    },
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(10),
                                                    ),
                                                    tileColor: FlutterFlowTheme.of(context).primaryBackground,
                                                    title: Text(
                                                      controller.listOfAllLevels[index1]
                                                          .lessons[index2].title,
                                                      maxLines: 4,
                                                      style: TextStyle(
                                                          fontSize: 15, color: theme.primary),
                                                    ))),
                                            Divider(color: theme.primary,),
                                            if(controller.listOfAllLevels[index1].lessons[index2] == controller.listOfAllLevels[index1].lessons.last)
                                              GestureDetector(
                                                onTap: () {

                                                  Get.to(() => QuizScreen(subcatID: controller.listOfAllLevels[index1].lessons[index2].subcategoryId.toString(), levelId: controller.listOfAllLevels[index1].id.toString(),));
                                                },
                                                child:  Card(
                                                    color: theme.primary,
                                                    child: Padding(
                                                      padding: EdgeInsets.all(8.0),
                                                      child: Text('Take quiz', style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                        fontFamily: 'Poppins',
                                                      ),),
                                                    )),
                                              )
                                          ],
                                        );
                                      }),
                                ),
                                // AccordionSection(header: Text('take quiz'), content: Text('take quiz for this lesson'))
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),]
        ));
  }
}
