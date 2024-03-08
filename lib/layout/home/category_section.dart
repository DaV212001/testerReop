import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:get/get.dart';
import 'package:mss_e_learning/controller/category_controller.dart';
import 'package:mss_e_learning/layout/home/all_category_screen.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import '../../controller/lesson_controllers.dart';
import '../../screen/lesson/lesson_screen.dart';
import '../../screen/subcategory/sub_category_screen.dart';
import '../../widget/course_header.dart';
import '../../widget/home/category_card.dart';
import '../../widget/sub_category/sub_category_card.dart';

class SubCatGrid extends StatelessWidget {
  const SubCatGrid({super.key});

  @override
  Widget build(BuildContext context) {
    CategoryController controller = Get.put(CategoryController());
    return Obx(() => RefreshIndicator(
                color: FlutterFlowTheme.of(context).primaryBackground,
                displacement: 100,
                onRefresh: () => controller.getCategories(),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: controller.listOfAllCategories.length,
                    itemBuilder: (context, iindex){
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          // CourseHeader(
                          //   title: controller.listOfAllCategories[iindex].name,
                          //   showMore: true,
                          //   showMoreText: "See more",
                          //   onTap: () {
                          //     pushNewScreen(context, screen: SubCategoryScreen(
                          //         subCategory: controller
                          //             .listOfAllCategories[iindex]
                          //             .subcategory,
                          //         subCategoryName: controller
                          //             .listOfAllCategories[iindex].name));
                          //   },
                          // ),
                          MasonryGridView.count(
                              itemCount: controller
                                  .listOfAllCategories[iindex]
                                  .subcategory.length,
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              crossAxisCount: 2,
                              mainAxisSpacing: 4,
                              crossAxisSpacing: 4,
                              shrinkWrap: true,
                              padding: const EdgeInsets.all(0),
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    LessonController levelController =
                                    Get.put(LessonController());
                                    levelController.subCategoryId.value =
                                        controller.listOfAllCategories[iindex].subcategory[index].id.toString();
                                    print(
                                        levelController.subCategoryId.value);
                                    levelController.getLevels(
                                        controller.listOfAllCategories[iindex].subcategory[index].id.toString());
                                    pushNewScreen(context,
                                        screen: LessonScreen(
                                          subCategoryImage: controller.listOfAllCategories[iindex].subcategory[index].image!,
                                            subCategoryId:
                                            controller.listOfAllCategories[iindex].subcategory[index].id!,
                                            courseName:
                                            controller.listOfAllCategories[iindex].subcategory[index].name!));
                                  },
                                  child: SubCategoryCard(
                                      name:  controller.listOfAllCategories[iindex].subcategory[index].name!,
                                      image:  controller.listOfAllCategories[iindex].subcategory[index].image!),
                                );
                              })
                        ],
                      ),
                    );

                })
                ));
  }
}
