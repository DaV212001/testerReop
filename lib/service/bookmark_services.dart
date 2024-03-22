import 'dart:convert';

import 'package:http/http.dart';

import '../model/bookmark.dart';
import '../model/lesson.dart';
import '../util/app_constants.dart';
import 'authorization_service.dart';

class BookMarkServices{

  static Future<dynamic> fetchBookmarks(int page) async {
    bool endingPage = false;
    final response = await get(
        Uri.parse(
            '${AppConstants.api}/book_mark?page=$page&populate=true&paginate=10'),
        headers: {
          'Authorization': 'Bearer ${await AuthService.getAuthorizationToken()}'
        });
    print(response.body);
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      List<dynamic> bookmarkList = jsonData['data']['data'];
      if(jsonData['data']['next_page_url'] == null){
        endingPage = true;
      }
      final List<dynamic> placeholderEnabler = ['Certificates(subcategory'];
      // Parse the certificateList and return a list of Certificates
      var bookmarks =
      bookmarkList.map((json) => BookMark.fromJson(json)).toList();
      return [bookmarks, endingPage];
    } else {
      throw Exception('Failed to load certificates');
    }
  }

  static Future<List<BookMark>> fetchBookmarksAllAtOnce() async {
    final response = await get(
        Uri.parse(
            '${AppConstants.api}/book_mark?&populate=true'),
        headers: {
          'Authorization': 'Bearer ${await AuthService.getAuthorizationToken()}'
        });
    print(response.body);
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      List<dynamic> bookmarkList = jsonData['data']['data'];

      final List<dynamic> placeholderEnabler = ['Certificates(subcategory'];
      // Parse the certificateList and return a list of Certificates
      var bookmarks =
      bookmarkList.map((json) => BookMark.fromJson(json)).toList();
      return bookmarks;
    } else {
      throw Exception('Failed to load certificates');
    }
  }


}