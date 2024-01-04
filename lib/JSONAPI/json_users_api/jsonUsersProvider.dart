import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'jsonUsersDataModel.dart';

class UserProvider extends ChangeNotifier {
  List<User> _users = [];

  List<User> get users => _users;

  Future<void> fetchUsers() async {
    try {
      var response = await http.get(
        Uri.parse("https://jsonplaceholder.typicode.com/users"),
        headers: {},
      );

      if (response.statusCode == 200) {
        List<dynamic> jsonData = jsonDecode(response.body);
        List<User> fetchedUsers = jsonData.map((json) => User.fromJson(json)).toList();

        _users = fetchedUsers;
        notifyListeners();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Failed to load data: $e');
    }
  }

  // Method for POST request
  Future<User> createUser(User user) async {
    try {
      var postResponse = await http.post(
        Uri.parse("https://jsonplaceholder.typicode.com/users"),
        body: jsonEncode(user.toJson()),
        headers: {'Content-Type': 'application/json'},
      );

      if (postResponse.statusCode == 201) {
        final newUser = User.fromJson(jsonDecode(postResponse.body));
        _users.add(newUser);
        notifyListeners();
        return newUser;
      } else {
        throw Exception('Failed to create user');
      }
    } catch (e) {
      throw Exception('Failed to create user: $e');
    }
  }

  // Method for DELETE request
  Future<void> deleteUser(int userId) async {
    try {
      var deleteResponse = await http.delete(
        Uri.parse("https://jsonplaceholder.typicode.com/users/$userId"),
        headers: {'Content-Type': 'application/json'},
      );

      if (deleteResponse.statusCode == 200) {
        _users.removeWhere((user) => user.id == userId);
        notifyListeners();
      } else {
        throw Exception('Failed to delete user');
      }
    } catch (e) {
      throw Exception('Failed to delete user: $e');
    }
  }

  // Method for PUT request
  Future<User> updateUser(User user) async {
    try {
      var putResponse = await http.put(
        Uri.parse("https://jsonplaceholder.typicode.com/users/${user.id}"),
        body: jsonEncode(user.toJson()),
        headers: {'Content-Type': 'application/json'},
      );

      if (putResponse.statusCode == 200) {
        final updatedUser = User.fromJson(jsonDecode(putResponse.body));
        _users[_users.indexWhere((u) => u.id == updatedUser.id)] = updatedUser;
        notifyListeners();
        return updatedUser;
      } else {
        throw Exception('Failed to update user');
      }
    } catch (e) {
      throw Exception('Failed to update user: $e');
    }
  }
}
