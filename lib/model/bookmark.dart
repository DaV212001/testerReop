import 'lesson.dart';

class BookMark{
  int? id;
  String? lessonId;
  String? userId;
  Lesson? lessons;

  BookMark({
    this.id,
    this.lessonId,
    this.userId,
    this.lessons
  });

  factory BookMark.fromJson(Map<String, dynamic> json) {
    return BookMark(
      id: json['id'],
      lessonId: json['lesson_id'],
      userId: json['user_id'],
      lessons: json['post'] != null ? Lesson.fromJson(json['post']) : null,
    );
  }

}