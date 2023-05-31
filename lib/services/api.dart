import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:project_uts/models/post.dart';

class ApiStatic {
  static const host = 'http://10.10.14.65';
  static const _token = "Bearer 2|jETEFjWBoNiPAPDVYHrHwGdMmjk9Ub3EdHR67MRq";
  static Future<List<Post>> getPost() async {
    try {
      final response = await http.get(Uri.parse("$host/api/posts"), headers: {
        'Authorization': _token,
      });
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        final parsed = json['data'].cast<Map<String, dynamic>>();
        return parsed.map<Post>((json) => Post.fromJson(json)).toList();
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  static Future<Post> createPost(Post post) async {
    try {
      final response = await http.post(
        Uri.parse("$host/api/posts"),
        headers: {
          'Authorization': 'Bearer 2|jETEFjWBoNiPAPDVYHrHwGdMmjk9Ub3EdHR67MRq',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(post.toJson()),
      );
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        return Post.fromJson(json);
      } else {
        throw Exception('Failed to create post');
      }
    } catch (e) {
      throw Exception('Failed to create post: $e');
    }
  }
}
