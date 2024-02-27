class SubCategory {
  int id;
  String name;
  String image;
  String categoryId;

  SubCategory({
    required this.id,
    required this.name,
    required this.image,
    required this.categoryId
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) {
    return SubCategory(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      categoryId: json['category_id'],
    );
  }
}