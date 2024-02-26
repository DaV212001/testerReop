
import 'package:mss_e_learning/model/video_book.dart';

class LessonDescription {
  int id;
  String image;
  String title;
  String description;
  String subcategoryId;
  String levelId;
  String createdAt;
  String updatedAt;
  List<Video> videos;
  List<Book> books;

  LessonDescription({
    required this.id,
    required this.image,
    required this.title,
    required this.description,
    required this.subcategoryId,
    required this.levelId,
    required this.createdAt,
    required this.updatedAt,
    required this.videos,
    required this.books
  });

  factory LessonDescription.fromJson(Map<String, dynamic> json) {
    print(json);
    List<Video> videosList = [];
    List<Book> booksList = [];

    if (json['videos'] != null) {
      videosList = List<Video>.from(json['videos'].map((video) => Video.fromJson(video)));
    }

    if (json['books'] != null) {
      booksList = List<Book>.from(json['books'].map((book) => Book.fromJson(book)));
    }

    return LessonDescription(
        id: json['id'],
        image: json['image'],
        title: json['title'],
        description: json['description'],
        subcategoryId: json['subcategory_id'],
        levelId: json['level_id'],
        createdAt: json['created_at'],
        updatedAt: json['updated_at'],
        videos: videosList,
        books: booksList
    );
  }
}



