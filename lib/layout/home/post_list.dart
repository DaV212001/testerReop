import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/post_controller.dart';
import '../../screen/lesson/lesson_screen.dart';
import '../../util/app_constants.dart';

class PostList extends StatelessWidget {
  const PostList({super.key});

  @override
  Widget build(BuildContext context) {
    PostController controller = Get.put(PostController());
    return Flexible(
      child: Obx(() => controller.isLoading
          ? const SizedBox(
              width: 50, height: 50, child: CircularProgressIndicator(color: AppConstants.primary,))
          : RefreshIndicator(
              color: Theme.of(context).primaryColor,
              displacement: 100,
              onRefresh: () => controller.getPostsFromApi(),
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemCount: controller.getAllPosts.length,
                separatorBuilder: (_, __) => const Divider(),
                itemBuilder: (ctx, index) => GestureDetector(
                  onTap: (){
                    // Get.to( () => const LessonScreen(lessonId: 1, subCategoryId: controller.getAllPosts[index].id,));
                  },
                  child: ListTile(
                    title: Text(
                      controller.getAllPosts[index].title,
                      maxLines: 1,
                    ),
                    subtitle: Text(
                      controller.getAllPosts[index].body,
                      maxLines: 2,
                    ),
                    leading: CircleAvatar(
                      radius: 30,
                      child: Text(
                        controller.getAllPosts[index].id.toString(),
                      ),
                    ),
                  ),
                ),
              ),
            )),
    );
  }
}
