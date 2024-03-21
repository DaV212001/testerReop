import 'dart:convert';

import 'package:http/http.dart';
import 'package:mss_e_learning/util/app_constants.dart';
import '../model/privacy_policy.dart';

class PrivacyPolicyService{

  Future<PrivacyPolicy?>? getPrivacyPolicy() async {
    var response = await get(Uri.parse('${AppConstants.api}/privacy_policy'));
    if(response.statusCode == 200){
      var data = jsonDecode(response.body);
      Map<String, dynamic> privacyData = data['data'];
      PrivacyPolicy privacyPolicy = PrivacyPolicy.fromJson(privacyData);
      return privacyPolicy;
    }
    return null;
  }
}