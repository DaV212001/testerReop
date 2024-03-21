import 'dart:convert';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:http/http.dart';
import 'package:mss_e_learning/model/sub_category.dart';
import 'package:mss_e_learning/service/authorization_service.dart';
import 'package:mss_e_learning/util/app_constants.dart';
import '../model/certificate.dart';
import '../util/certificate_placeholder.dart';

class CertificateServices {
  static Future<List<dynamic>> fetchCertificates(int page) async {
    bool endingPage = false;
    final response = await get(
        Uri.parse(
            '${AppConstants.api}/certificate?page=$page&populate=true&paginate=10'),
        headers: {
          'Authorization': 'Bearer ${await AuthService.getAuthorizationToken()}'
        });
    print(response.body);
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      List<dynamic> certificateList = jsonData['data']['data'];
      if(jsonData['data']['next_page_url'] == null){
        endingPage = true;
      }
      final List<dynamic> placeholderEnabler = ['Certificates(subcategory'];
      // Parse the certificateList and return a list of Certificates
      var certificates =
          certificateList.map((json) => Certificates.fromJson(json)).toList();
      return [certificates, endingPage];
    } else {
      throw Exception('Failed to load certificates');
    }
  }

  Future<String> generateCertificate() async {
    const String apiUrl = '${AppConstants.api}/certificate?populate=true';
    String success = '';
    try {
      final response = await get(Uri.parse(apiUrl));
      final responseData = jsonDecode(response.body);

      if (responseData['success']) {
        final List<dynamic> certificates = responseData['data']['data'];
        for (final certificate in certificates) {
          if (certificate['certificate'] == '') {
            final String certificateId = certificate['id'].toString();
            final String updatedApiUrl = '${AppConstants.api}/generate_certificate/$certificateId?populate=true';

            final response2 = await post(
              Uri.parse(updatedApiUrl),
              headers: {
                'Authorization': 'Bearer ${await AuthService.getAuthorizationToken()}',
                'Content-Type': 'application/json',
              },
            );

            final responseData2 = jsonDecode(response2.body);
            final bool success2 = responseData2['success'];
            final String message2 = responseData2['message'];

            if (success2) {
              success = 'success';
              print('Data created successfully');
              // Handle other logic here if needed
            } else {
              success = 'failed';
              throw Exception(message2);
            }
            break; // Stop after finding the first matching certificate
          }
        }
      } else {
        success = 'failed';
        throw Exception(responseData['message']);
      }
    } catch (e) {
      print('Error: $e');
      success = 'failed';
      Exception('An error occurred while generating the certificate.');
    }

    return success;
  }


}
