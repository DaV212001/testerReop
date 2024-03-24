import 'package:get/get.dart';

import '../model/level.dart';

class LevelController extends GetxController {
  // Observable list to store opened lesson IDs
  RxList<int> openedLessons = <int>[].obs;

  // Method to add an opened lesson ID
  void addOpenedLesson(int lessonId) {
    if (!openedLessons.contains(lessonId)) {
      print('CALLLED!!!!!!!!!!!!!!!');
      openedLessons.add(lessonId);
    }
  }
  bool allLessonsOpened(Level level) {
    // Check if every lesson in the level has been opened
    return level.lessons.every((lesson) => openedLessons.contains(lesson.id));
  }
}
