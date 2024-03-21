import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:get/get.dart';
import 'package:mss_e_learning/controller/category_controller.dart';
import 'package:mss_e_learning/model/sub_category.dart';
import 'package:mss_e_learning/util/api_call_status.dart';
import 'package:mss_e_learning/widget/error_card.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

import '../../controller/lesson_controllers.dart';
import '../../widget/sub_category/sub_category_card.dart';
import '../lesson/lesson_screen.dart';

class CategoryDetailScreen extends StatelessWidget {
  int categoryId;

  CategoryDetailScreen(
      {super.key, required this.categoryId});

  @override
  Widget build(BuildContext context) {
    final FlutterFlowTheme theme = FlutterFlowTheme.of(context);
    CategoryController controller = Get.put(CategoryController());
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: theme.primary));
    List<SubCategory> subCategories = controller.listOfAllCategories.firstWhere((element) => element.id == categoryId).subcategories;
    String categoryName= controller.listOfAllCategories.firstWhere((element) => element.id == categoryId).name;
    return Scaffold(
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        title: Text(
          categoryName,
          style: TextStyle(color: theme.primaryText),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: theme.primaryText,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SafeArea(
          child: Center(
        child: Obx(
          () => controller.status.value == ApiCallStatus.loading
              ? const SizedBox(
                  width: 50, height: 50, child: CircularProgressIndicator())
              : controller.status.value == ApiCallStatus.error
                  ? ErrorCard(
                      errorData: controller.errorData.value,
                      refresh: () => controller.getCategories(),
                    )
                  : ListView(children: [
                      RefreshIndicator(
                          color: Theme.of(context).primaryColor,
                          displacement: 100,
                          onRefresh: () => controller.getCategories(),
                          child: Column(children: [
                            MasonryGridView.count(
                                itemCount: subCategories.length,
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
                                      LessonController levelController =
                                          Get.put(LessonController(subcategoryId: subCategories[index].id.toString()));
                                      levelController.subCategoryId.value =
                                          subCategories[index].id.toString();
                                      print(
                                          levelController.subCategoryId.value);
                                      levelController.getLevels(
                                          subCategories[index].id.toString());
                                      pushNewScreen(context,
                                          screen: SubCategoryDetailScreen(
                                            subCategoryImage: subCategories[index].image!,
                                              subCategoryId:
                                                  subCategories[index].id!,
                                              courseName:
                                                  subCategories[index].name!));
                                    },
                                    child: SubCategoryCard(
                                      name: subCategories[index].name!,
                                      image: subCategories[index].image!,
                                      price: subCategories[index].price!.toString(),
                                    ),
                                  );
                                })
                          ]))
                    ]),
        ),
      )),
    );
  }
}
