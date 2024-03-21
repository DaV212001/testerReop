class PrivacyPolicy{
  int? id;
  String? title;
  String? description;

  PrivacyPolicy({
    this.id,
    this.title,
    this.description
  });

  PrivacyPolicy.fromJson(Map<String, dynamic> json){
    id = json['id'];
    title = json['title'];
    description = json['description'];
  }
}