import 'dart:convert';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:http/http.dart';
import 'package:mss_e_learning/model/sub_category.dart';
import 'package:mss_e_learning/service/authorization_service.dart';
import '../model/certificate.dart';
import '../util/certificate_placeholder.dart';

class CertificateServices {
  static Future<List<Certificates>> fetchCertificates(int page) async {
    final response = await get(Uri.parse(
        'https://learning.bhwethiopia.com/api/certificate?populate=true&paginate=10'),
      headers: {
      'Authorization': 'Bearer ${await AuthService.getAuthorizationToken()}'
      }
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      // final List<dynamic> certificateList = jsonData['data'];
      final List<dynamic> placeholderEnabler = ['Certificates(subcategory'];
      // Parse the certificateList and return a list of Certificates
      List<Certificates> certificates = placeholderEnabler
          .map((json) => Certificates.fromJson(jsonDecode(jsonEncode(CertificatePlaceHolder().data))))
          .toList();
      print(certificates[0].subcategory.name);
      return certificates;
    } else {
      throw Exception('Failed to load certificates');
    }
  }
}
