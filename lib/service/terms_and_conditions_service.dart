import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/terms_and_conditions.dart';

class TermAndConditionService {
  Future<TermAndCondition> fetchTermAndCondition() async {
    final response = await http.get(Uri.parse('https://learning.bhwethiopia.com/api/term_and_condition'));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final termAndConditionData = jsonData['data'];
      return TermAndCondition.fromJson(termAndConditionData);
    } else {
      throw Exception('Failed to load Terms and Conditions');
    }
  }
}
