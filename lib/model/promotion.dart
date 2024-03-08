import 'dart:convert';

class Promotion{
  int? id;
  String? title;
  String? image;
  int? lessonId;

  Promotion({
    this.id,
    this.title,
    this.image,
    this.lessonId
  });

  Promotion.fromJson(Map<String, dynamic> json){
    id = json['id'];
    title = json['title'];
    image = json['image'];
    lessonId = jsonDecode(jsonEncode(json['post']))['id'];
  }
}