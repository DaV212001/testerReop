class User {
  String? firstname;
  String? lastname;
  String? email;
  String? phone;
  int? id;

  User({
    this.firstname,
    this.lastname,
    this.email,
    this.phone,
    this.id
  });

  User.fromJson(Map<String, dynamic> json) {
    firstname = json['first_name'];
    lastname = json['last_name'];
    email = json['email'];
    phone = json['phone'];
    id = json['id'];
  }


}