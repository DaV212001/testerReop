import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:get/get.dart';
import 'package:mss_e_learning/controller/category_controller.dart';
import 'package:mss_e_learning/layout/home/all_category_screen.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import '../../controller/lesson_controllers.dart';
import '../../model/lesson.dart';
import '../../screen/lesson/lesson_screen.dart';
import '../../screen/subcategory/sub_category_screen.dart';
import '../../widget/course_header.dart';
import '../../widget/home/category_card.dart';
import '../../widget/sub_category/sub_category_card.dart';
import '../lesson/lesson_details.dart';

class SubCatGrid extends StatelessWidget {
  final List<Lesson> listOfLessons;
  const SubCatGrid({super.key, required this.listOfLessons});

  @override
  Widget build(BuildContext context) {
    CategoryController controller = Get.put(CategoryController());
    return Obx(() => RefreshIndicator(
                color: FlutterFlowTheme.of(context).primaryBackground,
                displacement: 100,
                onRefresh: () => controller.getCategories(),
                child: MasonryGridView.count(
                        itemCount: listOfLessons.length,
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
                              Get.to(()=> LessonDetailScreen(lessonId: listOfLessons[index].id));
                            },
                            child: SubCategoryCard(
                                name:  listOfLessons[index].title,
                                image:  listOfLessons[index].image,
                                price: '',
                            ),
                          );
                        })


                ));
  }
}
