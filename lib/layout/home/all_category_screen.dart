import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:mss_e_learning/controller/category_controller.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

import '../../screen/subcategory/sub_category_screen.dart';
import '../../widget/home/category_card.dart';

class AllCategoryScreen extends StatelessWidget {
  const AllCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    CategoryController controller = Get.put(CategoryController());
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Text("All categories", style: theme.textTheme.titleLarge),
        ),
        body: SafeArea(
            child: Flexible(
                child: RefreshIndicator(
                    color: Theme.of(context).primaryColor,
                    displacement: 100,
                    onRefresh: () => controller.getCategories(),
                    child: MasonryGridView.count(
                        itemCount: controller.listOfAllCategories.length,
                        physics: BouncingScrollPhysics(),
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
                                            .listOfAllCategories[index].name));
                              },
                              child: CategoryCard(
                                name:
                                    controller.listOfAllCategories[index].name,
                                image:
                                    controller.listOfAllCategories[index].image,
                                numberOfCourses: controller
                                    .listOfAllCategories[index]
                                    .subcategory
                                    .length
                                    .toString(),
                              ));
                        })))));
  }
}
