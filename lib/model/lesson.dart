class Lesson {
  int id;
  String image;
  String title;
  String description;
  String subcategoryId;
  String levelId;

  Lesson({
    required this.id,
    required this.image,
    required this.title,
    required this.description,
    required this.subcategoryId,
    required this.levelId
  });

  factory Lesson.fromJson(Map<String, dynamic> json) {

    return Lesson(
        id: json['id'],
        image: json['image'],
        title: json['title'],
        description: json['description'],
        subcategoryId: json['subcategory_id'],
        levelId: json['level_id']
    );
  }
}




