import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'jsonAlbumDataModel.dart';
import 'dart:convert';


class JsonAlbumProvider extends ChangeNotifier {
  List<Album> _posts = [];

  List<Album> get posts => _posts;

  // Existing methods...
  Future<void> fetchPosts() async {
    try {
      var response = await http.get(
        Uri.parse("https://jsonplaceholder.typicode.com/albums"),
        headers: {},
      );

      if (response.statusCode == 200) {
        List<dynamic> jsonData = jsonDecode(response.body);
        List<Album> fetchedPosts =
        jsonData.map((json) => Album.fromJson(json)).toList();

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
  Future<Album> createPost(Album album) async {
    try {
      var postResponse = await http.post(
        Uri.parse("https://jsonplaceholder.typicode.com/albums"),
        body: jsonEncode(album.toJson()),
        headers: {'Content-Type': 'application/json'},
      );

      if (postResponse.statusCode == 201) {
        final newPost = Album.fromJson(jsonDecode(postResponse.body));
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
        Uri.parse("https://jsonplaceholder.typicode.com/albums/$postId"),
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
  Future<Album> updatePost(Album album) async {
    try {
      var putResponse = await http.put(
        Uri.parse("https://jsonplaceholder.typicode.com/albums/${album.id}"),
        body: jsonEncode(album.toJson()),
        headers: {'Content-Type': 'application/json'},
      );

      if (putResponse.statusCode == 200) {
        final replacedPost = Album.fromJson(jsonDecode(putResponse.body));
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