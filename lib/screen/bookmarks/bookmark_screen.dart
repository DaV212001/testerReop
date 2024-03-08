import 'package:flutter/material.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:mss_e_learning/controller/bookmark_controller.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:mss_e_learning/screen/lesson/lesson_screen.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import '../../layout/lesson/lesson_details.dart';
import '../../util/api_call_status.dart';
import '../../widget/error_card.dart';
import '../../widget/home/category_card.dart';
import '../../widget/load_more_button.dart';
import '../../widget/sub_category/sub_category_card.dart';
import '../subcategory/sub_category_screen.dart';


class BookMarkScreen extends StatefulWidget {
  const BookMarkScreen({super.key});

  @override
  State<BookMarkScreen> createState() => _BookMarkScreenState();
}

class _BookMarkScreenState extends State<BookMarkScreen> {
  @override
  Widget build(BuildContext context) {
    final FlutterFlowTheme theme = FlutterFlowTheme.of(context);
    BookMarkController controller = Get.put(BookMarkController());
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
            refresh: () => controller.fetchBookMarks(),
          )
              : RefreshIndicator(
              color: theme.primary,
              displacement: 100,
              onRefresh: () => controller.fetchBookMarks(),
              child: MasonryGridView.count(
                  itemCount: controller.bookmarks.length+1,
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  crossAxisCount: 2,
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(10),
                  itemBuilder: (context, index) {
                    if (index < controller.bookmarks.length) {
                      return GestureDetector(
                          onTap: ()
                          {
                            pushNewScreen(context,
                                screen: LessonDetailScreen(lessonId: controller.bookmarks[index].lessons!.id,));
                          },
                          child: SubCategoryCard(
                            name:
                            controller.bookmarks[index].lessons!.title,
                            image:
                            controller.bookmarks[index].lessons!.image,
                          ));
                    } else if (controller.hasMorePages.value) {
                      // Show a loading indicator or button to load more
                      return LoadMoreButton(
                          onTap:(){
                            controller.fetchBookMarks();
                          }
                      );
                    } else {
                      // No more pages
                      return SizedBox.shrink();
                    }
                  }
                  ),
          ),
          ),
      ),
    );
  }
}
