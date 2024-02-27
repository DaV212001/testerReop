import 'package:flutter/material.dart';
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
    ThemeData theme = Theme.of(context);

    LessonController controller = Get.put(
        LessonController()
    );

    return Scaffold(
        appBar: AppBar(
          title: Text(courseName),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            Flexible(
                child: Obx(() => controller.isLoading
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
                          headerBackgroundColorOpened: theme.colorScheme.primary,
                          contentBackgroundColor: theme.colorScheme.primary,
                          contentBorderColor: theme.colorScheme.primary,
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
                              leftIcon: Icon(Icons.circle, color: theme.colorScheme.primary),
                              headerBackgroundColor: theme.colorScheme.secondary,
                              headerBackgroundColorOpened: theme.colorScheme.secondary,
                              headerBorderColorOpened: theme.colorScheme.secondary,
                              headerBorderWidth: 5,
                              contentBackgroundColor: theme.colorScheme.secondary,
                              contentBorderColor: theme.colorScheme.secondary,
                              contentBorderWidth: 2,
                              contentVerticalPadding: 15,
                              header: Text(controller.listOfAllLevels[index1].name,
                                  style: theme.textTheme.labelLarge),
                              content: ListView.builder(
                                  itemCount: controller.listOfAllLevels[index1].lessons.length,
                                  scrollDirection: Axis.vertical,
                                  physics: const BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: (context, index2) {
                                    return GestureDetector(
                                      onTap: (){
                                        pushNewScreen(context,
                                            screen: LessonDetailScreen(lessonId: controller.listOfAllLevels[index1].lessons[index2].id));
                                      },
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                                            child: Flexible(
                                              child: Text(
                                                  controller.listOfAllLevels[index1].lessons[index2].title,
                                                  maxLines: 4,
                                                  style: theme.textTheme.labelLarge
                                              ),
                                            ),
                                          ),
                                          const Divider(height: 1,thickness: 1)
                                        ],
                                      ),
                                    );
                                  }),
                            )
                          ],
                        );
                      },)
                ))
            )
          ],
        ));
  }
}