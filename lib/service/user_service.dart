import 'dart:convert';

import 'package:http/http.dart';
import 'package:mss_e_learning/model/user.dart';

class UserService{


  Future<User> signUserUp(
      String? firstn,
      String? lastn,
      String? email,
      String? phone,
      String? pass,
      ) async {
    // take textfield inputs and use them to make an api call to register the user
// Define the API endpoint URL
    final String apiUrl = 'https://learning.cheretanet.com/api/register';

    // Create a Map object with the user data
    final Map<String, dynamic> userData = {
      'first_name': firstn,
      'last_name': lastn,
      'email': email,
      'phone': phone,
      'password': pass,
    };
print(jsonEncode(userData));
    // Make the API call using the post method from the http package
    final Response response = await post(
        Uri.parse(apiUrl),
        body: jsonEncode(userData),
        headers: {
          'Content-Type': 'application/json'
        }
    );
    print(response.statusCode);
print(response.body);
    // Check if the API call was successful
    if (response.statusCode == 200) {
      // Parse the response body into a UserStruct object

      var data = jsonDecode(response.body);
      if(data['success']){
      final User user = User.fromJson(data['data']);
      return user;
      }else{
        throw Exception(data['message']);
      }
    } else {
      // Throw an exception if the API call failed
      throw Exception('Failed to register user');
    }
  }

}