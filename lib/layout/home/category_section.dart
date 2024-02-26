import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:mss_e_learning/controller/category_controller.dart';
import 'package:mss_e_learning/layout/home/all_category_screen.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import '../../screen/subcategory/sub_category_screen.dart';
import '../../widget/course_header.dart';
import '../../widget/home/category_card.dart';

class CategorySection extends StatelessWidget {
  const CategorySection({super.key});

  @override
  Widget build(BuildContext context) {
    CategoryController controller = Get.put(CategoryController());
    return Flexible(
        child: Obx(() => controller.isLoading
            ? Center(
              child: const Padding(
                        padding: const EdgeInsets.all(50.0),
                        child: Center(child: CircularProgressIndicator()),
                      ),
            )
            : RefreshIndicator(
            color: Theme.of(context).primaryColor,
            displacement: 100,
            onRefresh: () => controller.getCategories(),
            child: Column(
                children: [
                  CourseHeader(title: "Category", showMore: true,showMoreText: "See more",
                  onTap: (){
                    pushNewScreen(context,
                        screen: const AllCategoryScreen());
                  },
                  ),
                  MasonryGridView.count(
                      itemCount: controller.listOfAllCategories.length,
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      crossAxisCount: 2,
                      mainAxisSpacing: 4,
                      crossAxisSpacing: 4,
                      shrinkWrap: true,
                      padding: EdgeInsets.all(10),
                      itemBuilder: (context, index) {
                       if(index < 4){
                         return GestureDetector(
                             onTap: () {
                               pushNewScreen(context,
                                   screen: SubCategoryScreen(
                                       subCategory: controller.listOfAllCategories[index]
                                           .subcategory,
                                       subCategoryName: controller.listOfAllCategories[index].name));
                             },
                             child: CategoryCard(
                               name:
                               controller.listOfAllCategories[index].name,
                               image:
                               controller.listOfAllCategories[index].image,
                               numberOfCourses: controller.listOfAllCategories[index]
                                   .subcategory
                                   .length
                                   .toString(),
                             ));
                       }else{
                         return SizedBox();
                       }
                      }
                  )
                ]
            )
        ))
    );
  }
}