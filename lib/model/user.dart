import 'package:mss_e_learning/util/app_constants.dart';

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
    if(json.containsKey('profile_picture')) {print(AppConstants.imagebaseurl+(json['profile_picture']));}

    firstname = json['first_name'];
    lastname = json['last_name'];
    email = json['email'];
    phone = json['phone'];
    id = json['id'];
    profilepicture = json.containsKey('profile_picture')? json['profile_picture'] != null? AppConstants.imagebaseurl+(json['profile_picture']) : null:'';
    roleid = json.containsKey('role_id')? json['role_id']??-1 : -1;
  }


}
