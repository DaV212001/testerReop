import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/level.dart';

class LevelController extends GetxController {
  // SharedPreferences instance
  late SharedPreferences _prefs;

  // Observable list to store opened lesson IDs
  RxList<int> openedLessons = <int>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Initialize SharedPreferences
    _initPrefs();
    // Load opened lessons
    _loadOpenedLessons();
  }

  Future<void> _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> _loadOpenedLessons() async {
    final List<int>? openedLessonIds = _prefs.getStringList('openedLessons')?.map((stringLessonID) => int.parse(stringLessonID)).toList();
    if (openedLessonIds != null) {
      openedLessons.assignAll(openedLessonIds);
    }
  }

  Future<void> _saveOpenedLessons() async {
    await _prefs.setStringList('openedLessons', openedLessons.map((intLessonID) => intLessonID.toString()).toList());
  }

  bool checkIfOpened(int lessonId) {
    return openedLessons.contains(lessonId);
  }

  // Method to add an opened lesson ID
  void addOpenedLesson(int lessonId) {
    if (!openedLessons.contains(lessonId)) {
      openedLessons.add(lessonId);
      // Save opened lessons
      _saveOpenedLessons();
    }
  }

  bool allLessonsOpened(Level level) {
    // Check if every lesson in the level has been opened
    return level.lessons.every((lesson) => openedLessons.contains(lesson.id));
  }
}
