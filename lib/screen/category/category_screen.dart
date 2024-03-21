import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:get/get.dart';
import 'package:mss_e_learning/controller/category_controller.dart';
import 'package:mss_e_learning/screen/subcategory/sub_category_screen.dart';
import 'package:mss_e_learning/util/api_call_status.dart';
import 'package:mss_e_learning/widget/error_card.dart';
import 'package:mss_e_learning/widget/home/category_card.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FlutterFlowTheme theme = FlutterFlowTheme.of(context);
    CategoryController controller = Get.put(CategoryController());
    return Scaffold(
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          title: Text("List of categories",
              style: theme.headlineSmall.override(fontFamily: 'Poppins')),),
      body: SafeArea(
          child: Obx(() => controller.status.value == ApiCallStatus.loading
              ? const Padding(
                  padding: EdgeInsets.all(40.0),
                  child: Center(child: CircularProgressIndicator()),
                )
              : controller.status.value == ApiCallStatus.error
                  ? ErrorCard(
                      errorData: controller.errorData.value,
                      refresh: () => controller.getCategories(),
                    )
                  : RefreshIndicator(
                      color: theme.primary,
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
                                      screen: CategoryDetailScreen(
                                          categoryId: controller
                                          .listOfAllCategories[index].id,));
                                },
                                child: CategoryCard(
                                  name:
                                      controller.listOfAllCategories[index].name,
                                  image:
                                      controller.listOfAllCategories[index].image,
                                  numberOfCourses: controller
                                      .listOfAllCategories[index]
                                      .subcategories
                                      .length
                                      .toString(),
                                ));
                          })))),
    );
  }
}
