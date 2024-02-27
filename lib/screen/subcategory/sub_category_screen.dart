import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:mss_e_learning/controller/category_controller.dart';
import 'package:mss_e_learning/model/sub_category.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

import '../../controller/lesson_controllers.dart';
import '../../widget/course_header.dart';
import '../../widget/sub_category/sub_category_card.dart';
import '../lesson/lesson_screen.dart';

class SubCategoryScreen extends StatelessWidget {
  List<SubCategory> subCategory;
  String subCategoryName;
  SubCategoryScreen({super.key, required this.subCategory, required this.subCategoryName});
  @override
  Widget build(BuildContext context) {
    CategoryController controller = Get.put(CategoryController());
    return Scaffold(
      appBar: AppBar(
        title: Text(subCategoryName),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SafeArea(
          child: ListView (
            children: [
              Flexible(
                  child: Obx(() => controller.isLoading
                      ? const SizedBox(
                      width: 50, height: 50, child: CircularProgressIndicator())
                      : RefreshIndicator(
                      color: Theme.of(context).primaryColor,
                      displacement: 100,
                      onRefresh: () => controller.getCategories(),
                      child: Column(
                          children: [
                            MasonryGridView.count(
                                itemCount: subCategory.length,
                                physics: BouncingScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                crossAxisCount: 2,
                                mainAxisSpacing: 4,
                                crossAxisSpacing: 4,
                                shrinkWrap: true,
                                padding: EdgeInsets.all(10),
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: (){
                                      LessonController levelController = Get.put(LessonController());
                                      levelController.subCategoryId.value = subCategory[index].id.toString();
                                      print(levelController.subCategoryId.value);
                                      levelController.getLevels(subCategory[index].id.toString());
                                      pushNewScreen(context,
                                          screen: LessonScreen(subCategoryId: subCategory[index].id,
                                              courseName:subCategory[index].name));
                                    },
                                    child: SubCategoryCard(
                                        name: subCategory[index].name,
                                        image: subCategory[index].image
                                    ),
                                  );
                                }
                            )
                          ]
                      )
                  ))
              )
            ],
          )
      ),
    );
  }
}