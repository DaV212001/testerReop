import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/post.dart';
import '../util/app_constants.dart';

class PostService {
  static Future<List<Post>> fetchPosts() async {
    final response = await http.get(Uri.parse('${AppConstants.api}/posts'));
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = json.decode(response.body);
      final List<dynamic> postsJson = jsonData["posts"];
      return postsJson.map((item) {
        return Post.fromJson(item);
      }).toList();
    }
    throw Exception();
  }
}
