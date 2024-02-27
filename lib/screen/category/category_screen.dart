import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:mss_e_learning/controller/category_controller.dart';
import 'package:mss_e_learning/screen/subcategory/sub_category_screen.dart';
import 'package:mss_e_learning/widget/home/category_card.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    CategoryController controller = Get.put(CategoryController());
    return Scaffold(
      appBar: AppBar(
        title: Text("List of categories", style: theme.textTheme.titleLarge),
      ),
      body: SafeArea(
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
                  onRefresh: () => controller.getCategories(),
                  child: MasonryGridView.count(
                      itemCount: controller.listOfAllCategories.length,
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      crossAxisCount: 2,
                      mainAxisSpacing: 4,
                      crossAxisSpacing: 4,
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(10),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                            onTap: () {
                              pushNewScreen(context,
                                  screen: SubCategoryScreen(
                                      subCategory: controller
                                          .listOfAllCategories[index]
                                          .subcategory,
                                      subCategoryName: controller
                                          .listOfAllCategories[index]
                                          .name));
                            },
                            child: CategoryCard(
                              name: controller
                                  .listOfAllCategories[index].name,
                              image: controller
                                  .listOfAllCategories[index].image,
                              numberOfCourses: controller
                                  .listOfAllCategories[index]
                                  .subcategory
                                  .length
                                  .toString(),
                            ));
                      })))),
    );
  }
}
