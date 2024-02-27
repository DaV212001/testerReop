import 'dart:convert';

import 'package:http/http.dart';
import 'package:mss_e_learning/model/user.dart';
import 'package:mss_e_learning/service/authorization_service.dart';
import 'package:mss_e_learning/util/app_constants.dart';

class UserService{


  Future<User> signUserUp(
      String? firstn,
      String? lastn,
      String? email,
      String? phone,
      String? pass,
      ) async {

    final String apiUrl = 'https://learning.cheretanet.com/api/register';

    final Map<String, dynamic> userData = {
      'first_name': firstn,
      'last_name': lastn,
      'email': email,
      'phone': phone,
      'password': pass,
    };

print(jsonEncode(userData));


    final Response response = await post(
        Uri.parse(apiUrl),
        body: jsonEncode(userData),
        headers: {
          'Content-Type': 'application/json'
        }
    );


    print(response.statusCode);
print(response.body);

    if (response.statusCode == 200) {

      var data = jsonDecode(response.body);

      if(data['success']){

      final User user = User.fromJson(data['data']);
      return user;

      } else{
        throw Exception(data['message']);
      }
    } else {
      throw Exception('Failed to register user');
    }
  }


  Future<User> logUserIn(
      String? emailorphone,
      String? pass,
      ) async {
    final String apiUrl = 'https://learning.bhwethiopia.com/api/login';

    // Create a Map object with the user data
    final Map<String, dynamic> userData = {
      'email_or_phone': emailorphone,
      'password': pass,
    };

    print(jsonEncode(userData));

    final Response response = await post(
        Uri.parse(apiUrl),
        body: jsonEncode(userData),
        headers: {
          'Content-Type': 'application/json'
        }
    );

    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {

      var data = jsonDecode(response.body);
      if(data['success']){
        final User user = User.fromJson(data['data']);
        await AuthService.setAuthorizationToken(data['token']);
        return user;
      }else{
        throw Exception(data['message']);
      }
    } else {
      // Throw an exception if the API call failed
      throw Exception('Failed to register user');
    }
  }

  Future<void> updateUser(String firstName, String lastName) async {
    try {
      final Map<String, String> data = {
        "first_name": firstName,
        "last_name" : lastName
      };
print(jsonEncode(data));
print(await AuthService.getAuthorizationToken());
      final response = await post(
        Uri.parse("${AppConstants.exampleAPI}/update_user"),
        headers: {
          "Content-type": "application/json",
          "Authorization": "Bearer ${await AuthService.getAuthorizationToken()}"
        },
        body: json.encode(data),
      );
      print(response.body);
var resData = jsonDecode(response.body);

      if (response.statusCode == 200 && resData['success'] == true) {
        print("User updated successfully!");
      } else {
        print("Error updating user: ${response.body}");
        throw Exception('Failed to update user');
      }
    } catch (e) {
      print("Exception occurred: $e");
      throw Exception('Failed to update user');
    }
  }



}