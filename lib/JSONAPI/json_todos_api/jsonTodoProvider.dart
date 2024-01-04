import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'jsonTodoDataModel.dart';
import 'dart:convert';


class JsonTodoProvider extends ChangeNotifier {
  List<Todos> _posts = [];

  List<Todos> get posts => _posts;

  // Existing methods...
  Future<void> fetchPosts() async {
    try {
      var response = await http.get(
        Uri.parse("https://jsonplaceholder.typicode.com/todos"),
        headers: {},
      );

      if (response.statusCode == 200) {
        List<dynamic> jsonData = jsonDecode(response.body);
        List<Todos> fetchedPosts =
        jsonData.map((json) => Todos.fromJson(json)).toList();

        _posts = fetchedPosts; // Update the list of posts
        notifyListeners(); // Notify listeners about the change
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Failed to load data: $e');
    }
  }

  // Method for POST request
  Future<Todos> createPost(Todos todos) async {
    try {
      var postResponse = await http.post(
        Uri.parse("https://jsonplaceholder.typicode.com/todos"),
        body: jsonEncode(todos.toJson()),
        headers: {'Content-Type': 'application/json'},
      );

      if (postResponse.statusCode == 201) {
        final newPost = Todos.fromJson(jsonDecode(postResponse.body));
        _posts.add(newPost); // Add the new post to the list
        notifyListeners(); // Notify listeners about the change
        return newPost;
      } else {
        throw Exception('Failed to create post');
      }
    } catch (e) {
      throw Exception('Failed to create post: $e');
    }
  }

  // Method for DELETE request
  Future<void> deletePost(int postId) async {
    try {
      var deleteResponse = await http.delete(
        Uri.parse("https://jsonplaceholder.typicode.com/todos/$postId"),
        headers: {'Content-Type': 'application/json'},
      );

      if (deleteResponse.statusCode == 200) {
        // Post successfully deleted
        _posts.removeWhere(
                (post) => post.id == postId); // Remove the post from the list
        notifyListeners(); // Notify listeners about the change
      } else {
        throw Exception('Failed to delete post');
      }
    } catch (e) {
      throw Exception('Failed to delete post: $e');
    }
  }

  // Method for PUT request
  Future<Todos> updatePost(Todos todos) async {
    try {
      var putResponse = await http.put(
        Uri.parse("https://jsonplaceholder.typicode.com/albums/${todos.id}"),
        body: jsonEncode(todos.toJson()),
        headers: {'Content-Type': 'application/json'},
      );

      if (putResponse.statusCode == 200) {
        final replacedPost = Todos.fromJson(jsonDecode(putResponse.body));
        _posts[_posts.indexWhere((p) => p.id == replacedPost.id)] =
            replacedPost; // Update the post in the list
        notifyListeners(); // Notify listeners about the change
        return replacedPost;
      } else {
        throw Exception('Failed to replace post');
      }
    } catch (e) {
      throw Exception('Failed to replace post: $e');
    }
  }
}