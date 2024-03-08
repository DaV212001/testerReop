
import 'package:mss_e_learning/model/video_book.dart';
import 'package:mss_e_learning/util/app_constants.dart';

class LessonDescription {
  int? id;
  String? image;
  String? title;
  String? description;
  String? subcategoryId;
  String? levelId;
  String? createdAt;
  String? updatedAt;
  List<Video>? videos;
  List<Book>? books;

  LessonDescription({
    this.id,
    this.image,
    this.title,
    this.description,
    this.subcategoryId, this.levelId,
    this.createdAt,
    this.updatedAt,
    this.videos,
    this.books
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
        image: AppConstants.imagebaseurl+json['image'],
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



