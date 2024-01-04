import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'ApiGetDataModel.dart';


class PostProvider extends ChangeNotifier {
  Future<List<Post>> fetchPosts() async {
    try {
      // GET request
      var response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"), headers: {});

      // POST request with dynamic data
      var postResponse = await http.post(Uri.parse("https://jsonplaceholder.typicode.com/posts"), body: {
        'userId': '1', // Replace with appropriate values
        'title': 'Sample Title',
        'body': 'Sample Body',
      }, headers: {});

      if (response.statusCode == 200) {
        List<dynamic> jsonData = jsonDecode(response.body);
        List<Post> posts = jsonData.map((json) => Post.fromJson(json)).toList();
        return posts;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Failed to load data: $e');
    }
  }
}

