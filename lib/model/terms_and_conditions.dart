class TermAndCondition {
  final int id;
  final String title;
  final String description;
  final String createdAt;
  final String updatedAt;

  TermAndCondition({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TermAndCondition.fromJson(Map<String, dynamic> json) {
    return TermAndCondition(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
