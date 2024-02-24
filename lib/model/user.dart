class User {
  String? firstname;
  String? lastname;
  String? email;
  String? phone;
  int? id;
  String? profilepicture;
  int? roleid;

  User({
    this.firstname,
    this.lastname,
    this.email,
    this.phone,
    this.id,
    this.profilepicture,
    this.roleid
  });

  User.fromJson(Map<String, dynamic> json) {
    firstname = json['first_name'];
    lastname = json['last_name'];
    email = json['email'];
    phone = json['phone'];
    id = json['id'];
    profilepicture = json.containsKey('profile_picture')? json['profile_picture'] : '';
    roleid = json.containsKey('role_id')? json['role_id']??-1 : -1;
  }


}
