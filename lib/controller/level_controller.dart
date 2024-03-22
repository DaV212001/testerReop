import 'package:get/get.dart';

class LevelController extends GetxController {
  // Observable list to store opened lesson IDs
  RxList<int> openedLessons = <int>[].obs;

  // Method to add an opened lesson ID
  void addOpenedLesson(int lessonId) {
    if (!openedLessons.contains(lessonId)) {
      openedLessons.add(lessonId);
    }
  }
}
