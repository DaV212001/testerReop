import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:mss_e_learning/controller/search_controller.dart';

import '../../util/api_call_status.dart';
import '../../widget/cached_image.dart';
import '../../widget/error_card.dart';


class SearchCoursesScreen extends StatefulWidget {
  const SearchCoursesScreen({super.key});

  @override
  State<SearchCoursesScreen> createState() => _SearchCoursesScreenState();
}

class _SearchCoursesScreenState extends State<SearchCoursesScreen> {

  SubCategoryController subCategoryController = Get.put(SubCategoryController());
  TextEditingController search = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        title: Text(
          'Search Courses',
          style: FlutterFlowTheme.of(context).headlineSmall.override(
            fontFamily: 'Poppins',
          ),
        ),
        centerTitle: false,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back_ios_new_rounded
          )
        ),
      ),
      body: Column(
        children: [
          Hero(
            tag: 'Search',
            child: SearchBar(
              controller: search,
              hintText: 'Search Courses...',
              backgroundColor: MaterialStatePropertyAll<Color>(FlutterFlowTheme.of(context).primaryBackground),
              trailing: const [
                Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(FontAwesomeIcons.magnifyingGlass),
              )],
              onChanged: (value) {
                subCategoryController.filterSubCategories(value);
              },
            ),
          ),
          Obx(
            () => subCategoryController.status.value == ApiCallStatus.loading?
            const Center(
              child: CircularProgressIndicator(),
            ):
            subCategoryController.status.value == ApiCallStatus.error?
            ErrorCard(
              errorData: subCategoryController.errorData.value,
              refresh: () => subCategoryController.fetchSubCategories(),
            ):
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: subCategoryController.filteredSubCategories.length,
                itemBuilder: (context, index) {
                  final subCategory = subCategoryController.filteredSubCategories[index];
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                      height: MediaQuery.of(context).size.width * 0.3,
                                      width: MediaQuery.of(context).size.width * 0.3,
                                      child: ClipRRect(
                                          borderRadius: BorderRadius.all(Radius.circular(15)),
                                          child: CachedImage(
                                            url: subCategory.image!,
                                            fit: BoxFit.fill,
                                          )
                                      )),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(subCategory.name!,
                                            style: FlutterFlowTheme.of(context).bodyLarge.override(
                                              fontFamily: 'Poppins',
                                            ),
                                          ),
                                          SizedBox(height: MediaQuery.of(context).size.width * 0.05,),
                                          Text(subCategory.categoryName!,
                                              style: FlutterFlowTheme.of(context).bodySmall.override(
                                                fontFamily: 'Poppins',
                                                color: FlutterFlowTheme.of(context).secondaryText
                                              )
                                          )
                                        ]
                                    ),
                                  )
                                ]
                              ),

                            ]
                          ),


                          ),
                      ),
                      Divider(

                      )
                    ],
                  );
                },
              ),
            )
              )]
              )
              );
  }
}
