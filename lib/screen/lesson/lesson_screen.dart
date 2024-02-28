import 'package:flutter/material.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

import '../../controller/lesson_controllers.dart';
import '../../layout/lesson/lesson_details.dart';
import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';

class LessonScreen extends StatelessWidget {
  int subCategoryId;
  String courseName;
  LessonScreen({super.key, required this.subCategoryId, required this.courseName});

  @override
  Widget build(BuildContext context) {
    final FlutterFlowTheme theme = FlutterFlowTheme.of(context);

    LessonController controller = Get.put(
        LessonController()
    );

    return Scaffold(
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(courseName,
            style: TextStyle(color: theme.primaryText),),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: theme.primaryText,),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            Obx(() => controller.isLoading
                ? const Center(
              child: Padding(
                padding: EdgeInsets.all(50.0),
                child: Center(child: CircularProgressIndicator()),
              ),
            )
                : RefreshIndicator(
                color: Theme.of(context).primaryColor,
                displacement: 100,
                onRefresh: () => controller.getLevels(controller.subCategoryId.value),
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  physics: const BouncingScrollPhysics(),
                  itemCount: controller.listOfAllLevels.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index1) {
                    return Accordion(
                      disableScrolling: false,
                      flipRightIconIfOpen: true,
                      headerBorderColor: Colors.blueGrey,
                      headerBorderColorOpened: Colors.transparent,
                      headerBorderWidth: 1,
                      headerBackgroundColorOpened: theme.primary,
                      contentBackgroundColor: theme.primary,
                      contentBorderColor: theme.primary,
                      contentBorderWidth: 3,
                      contentHorizontalPadding: 20,
                      scaleWhenAnimating: true,
                      openAndCloseAnimation: true,
                      headerPadding:
                      const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
                      sectionOpeningHapticFeedback: SectionHapticFeedback.heavy,
                      sectionClosingHapticFeedback: SectionHapticFeedback.light,
                      children: [
                        AccordionSection(
                          isOpen: index1 == 0 ? true:false,
                          leftIcon: Icon(Icons.circle, color: theme.primary),
                          headerBackgroundColor: theme.primary.withOpacity(0.15),
                          headerBackgroundColorOpened: theme.primary.withOpacity(0.15),
                          headerBorderColorOpened: theme.primary,
                          contentBackgroundColor: theme.primary.withOpacity(0.5),
                          contentBorderColor: theme.primary.withOpacity(0.3),
                          headerBorderWidth: 1,
                          contentBorderWidth: 1,
                          contentVerticalPadding: 15,
                          header: Text(controller.listOfAllLevels[index1].name,
                            style: TextStyle(fontSize: 18,
                                color: theme.primaryText
                            )),
                          content: ListView.builder(
                              itemCount: controller.listOfAllLevels[index1].lessons.length,
                              scrollDirection: Axis.vertical,
                              physics: const BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index2) {
                                return InkWell(
                                  customBorder: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  splashColor: theme.primary.withOpacity(0.3),
                                  highlightColor: theme.primary.withOpacity(0.25),
                                  child: ListTile(
                                      onTap: (){
                                        pushNewScreen(context,
                                            screen: LessonDetailScreen(lessonId: controller.listOfAllLevels[index1].lessons[index2].id));
                                      },
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    tileColor: theme.primary.withOpacity(0.15),
                                    title:Text(
                                      controller.listOfAllLevels[index1].lessons[index2].title,
                                      maxLines: 4,
                                      style: TextStyle(fontSize: 15,
                                          color: theme.primaryText
                                      ),
                                    )
                                )
                                );
                              }),
                        )
                      ],
                    );
                  },)
            ))
          ],
        ));
  }
}