class User {
  int? id;
  String firstName;
  String lastName;
  String? email;
  String? password;
  String? phone;
  String? profilePicture;
  String? role;
  String? createdAt;
  String? updatedAt;

  User(
      {required this.firstName,
      required this.lastName,
      this.email,
      this.password,
      this.phone,
      this.id,
      this.profilePicture,
      this.role,
      this.createdAt,
      this.updatedAt});
}
