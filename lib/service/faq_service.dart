import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/faq.dart';
import '../util/app_constants.dart';

class FAQService {
  Future<List<FAQ>> fetchFAQs({int page = 1}) async {
    final response = await http.get(Uri.parse('https://learning.bhwethiopia.com/api/faq?paginate=10&page=$page'));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final faqsList = jsonData['data']['data'] as List<dynamic>;
      return faqsList.map((json) => FAQ.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load FAQs');
    }
  }
}

