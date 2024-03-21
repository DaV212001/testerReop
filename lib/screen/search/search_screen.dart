import 'package:flutter/material.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:get/get.dart';
import 'package:mss_e_learning/controller/search_controller.dart';
import 'package:mss_e_learning/model/category.dart';
import 'package:mss_e_learning/model/lesson.dart';
import 'package:mss_e_learning/model/sub_category.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mss_e_learning/controller/search_controller.dart';
import 'package:mss_e_learning/model/category.dart';
import 'package:mss_e_learning/model/lesson.dart';
import 'package:mss_e_learning/model/sub_category.dart';
import 'package:mss_e_learning/screen/lesson/lesson_screen.dart';
import 'package:mss_e_learning/screen/subcategory/sub_category_screen.dart';
import 'package:mss_e_learning/widget/sub_category/sub_category_card.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

import '../../layout/lesson/lesson_details.dart';
import '../category/category_screen.dart';

class SearchScreen extends StatelessWidget {
  final SearchControllerr searchController = Get.put(SearchControllerr());
  final TextEditingController searchhController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchhController,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                hintText: 'Enter search term...',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    searchController.getSearchData(searchhController.text);
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: Obx(
                  () {
                if (searchController.categories.isEmpty &&
                    searchController.subcategories.isEmpty &&
                    searchController.lessons.isEmpty) {
                  return Center(child: Text('No results'));
                } else {
                  return DefaultTabController(
                    length: 3,
                    child: Column(
                      children: [
                        TabBar(
                          isScrollable: true,
                          tabAlignment: TabAlignment.center,
                          tabs: [
                            Tab(text: 'Categories'),
                            Tab(text: 'Subcategories'),
                            Tab(text: 'Lessons'),
                          ],
                        ),
                        Expanded(
                          child: TabBarView(
                            children: [
                              _buildCategoriesList(searchController.categories),
                              _buildSubcategoriesList(searchController.subcategories),
                              _buildLessonsList(searchController.lessons),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoriesList(List<Category> categories) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
        childAspectRatio: 0.75,
      ),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];
        return GestureDetector(
          onTap: (){
            pushNewScreen(context,
                screen: CategoryDetailScreen(
                    categoryId: category.id,));
          },
          child: SubCategoryCard(name: category.name, image: category.image, price: '',),
        );
      },
    );
  }

  Widget _buildSubcategoriesList(List<SubCategory> subcategories) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
        childAspectRatio: 0.75,
      ),
      itemCount: subcategories.length,
      itemBuilder: (context, index) {
        final subcategory = subcategories[index];
        return GestureDetector(
          onTap: (){
            Get.to(()=>SubCategoryDetailScreen(
              subCategoryId: subcategory.id!,
              subCategoryImage: subcategory.image!,
              courseName: subcategory.name!,
            ));
          },
          child: SubCategoryCard(name: subcategory.name!, image: subcategory.image!, price: subcategory.price.toString(),),
        );
      },
    );
  }

  Widget _buildLessonsList(List<Lesson> lessons) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
        childAspectRatio: 0.75,
      ),
      itemCount: lessons.length,
      itemBuilder: (context, index) {
        final lesson = lessons[index];
        return GestureDetector(
          onTap: (){
            pushNewScreen(context,
                screen: LessonDetailScreen(
                    lessonId: lesson.id));
          },
          child: SubCategoryCard(name: lesson.title, image: lesson.image, price: '',),
        );
      },
    );
  }
}
