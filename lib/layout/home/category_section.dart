import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:get/get.dart';
import 'package:mss_e_learning/controller/category_controller.dart';
import 'package:mss_e_learning/layout/home/all_category_screen.dart';
import 'package:mss_e_learning/main.dart';
import 'package:mss_e_learning/screen/payment/payment_screen.dart';
import 'package:mss_e_learning/service/user_service.dart';
import 'package:mss_e_learning/util/app_constants.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import '../../controller/lesson_controllers.dart';
import '../../model/lesson.dart';
import '../../screen/lesson/lesson_screen.dart';
import '../../screen/subcategory/sub_category_screen.dart';
import '../../widget/course_header.dart';
import '../../widget/home/category_card.dart';
import '../../widget/sub_category/sub_category_card.dart';
import '../lesson/lesson_details.dart';



class SubCatGrid extends StatefulWidget {
  final List<Lesson> listOfLessons;
  const SubCatGrid({super.key, required this.listOfLessons});

  @override
  State<SubCatGrid> createState() => _SubCatGridState();
}

class _SubCatGridState extends State<SubCatGrid> {
  CategoryController controller = Get.find(tag: 'Category');
  bool checking = false;
  bool star = false;
  @override
  Widget build(BuildContext context) {



    return Obx(() => RefreshIndicator(
        color: FlutterFlowTheme.of(context).primaryBackground,
        displacement: 100,
        onRefresh: () => controller.getSubCategoryById(AppConstants.subcatid),
        child: !checking? MasonryGridView.count(
            itemCount: widget.listOfLessons.length ~/ 2,
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            crossAxisCount: 2,
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
            shrinkWrap: true,
            padding: const EdgeInsets.all(0),
            itemBuilder: (context, index) {
              var lessonId = widget.listOfLessons[index].id;
              return GestureDetector(
                onTap: () async {
                    Get.to((){
                      return LessonDetailScreen(lessonId: lessonId);
                    });
                },
                child:
                SubCategoryCard(
                  name:  widget.listOfLessons[index].title,
                  image:  widget.listOfLessons[index].image,
                  price: '', isPremium: false,
                ),
              );
            }) : const Center(
            child: CircularProgressIndicator(
              color: AppConstants.primary,
            )
        )
    ));
  }
}
