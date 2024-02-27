import 'lesson.dart';

class Level {
  int id;
  String name;
  List<Lesson> lessons;

  Level({
    required this.id,
    required this.name,
    required this.lessons
  });

  factory Level.fromJson(Map<String, dynamic> json) {

    List<Lesson> lessonsList = [];
    if (json['lessons'] != []) {
      json['lessons'].forEach((lessonJson) {
        lessonsList.add(Lesson.fromJson(lessonJson));
      });
    }
    return Level(
      id: json['id'],
      name: json['name'],
      lessons: lessonsList,
    );
  }
}