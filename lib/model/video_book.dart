class Video {
  int id;
  String title;
  dynamic file;
  String url;
  dynamic image;
  String subcategoryId;
  String levelId;

  Video({
    required this.id,
    required this.title,
    required this.file,
    required this.url,
    required this.image,
    required this.subcategoryId,
    required this.levelId,
  });

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      id: json['id'],
      title: json['title'],
      file: json['file'],
      url: json['url'],
      image: json['image'],
      subcategoryId: json['subcategory_id'],
      levelId: json['level_id'],
    );
  }
}

class Book {
  int id;
  String title;
  String file;
  String url;
  dynamic image;
  String subcategoryId;
  String levelId;

  Book({
    required this.id,
    required this.title,
    required this.file,
    required this.url,
    required this.image,
    required this.subcategoryId,
    required this.levelId,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    print("booooooooooooooooooooooooooookkkkkkkkkkkkkkkkkkkkkk $json");
    return Book(
      id: json['id'] ?? "",
      title: json['title'] ?? "",
      file: json['file'] ?? "",
      url: json['url'] ?? "",
      image: json['image'] ?? "",
      subcategoryId: json['subcategory_id'] ?? "",
      levelId: json['level_id'] ?? "",
    );
  }
}