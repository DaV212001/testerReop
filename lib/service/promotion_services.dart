import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

import '../model/promotion.dart';
import '../util/app_constants.dart';
import 'authorization_service.dart';

class PromotionServices{

  static Future<List<Promotion>> getPromotions(int page) async {

    final response = await get(
        Uri.parse(
            '${AppConstants.api}/promotion?page=$page&populate=true&paginate=10'),
        headers: {
          'Authorization': 'Bearer ${await AuthService.getAuthorizationToken()}'
        });
      print(response.body);
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      List<dynamic> promotionsList = jsonData['data']['data'];

      final List<dynamic> placeholderEnabler = ['Certificates(subcategory'];
      // Parse the certificateList and return a list of Certificates
      var promotions =
      promotionsList.map((json) => Promotion.fromJson(json)).toList();
      return promotions;
    } else {
      throw Exception('Failed to load certificates');
    }
  }
}