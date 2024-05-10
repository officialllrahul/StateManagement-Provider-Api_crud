import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'jsonUsersDataModel.dart';

class UserProvider extends ChangeNotifier {
  List<User> _users = [];

  List<User> get users => _users;

  final Dio _dio = Dio();

  Future<void> fetchUsers() async {
    try {
      final response = await _dio.get(
        "https://jsonplaceholder.typicode.com/users",
        options: Options(headers: {}),
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = response.data;
        final List<User> fetchedUsers =
        jsonData.map((json) => User.fromJson(json)).toList();

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
      final response = await _dio.post(
        "https://jsonplaceholder.typicode.com/users",
        data: jsonEncode(user.toJson()),
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (response.statusCode == 201) {
        final newUser = User.fromJson(response.data);
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
      final response = await _dio.delete(
        "https://jsonplaceholder.typicode.com/users/$userId",
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (response.statusCode == 200) {
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
      final response = await _dio.put(
        "https://jsonplaceholder.typicode.com/users/${user.id}",
        data: jsonEncode(user.toJson()),
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (response.statusCode == 200) {
        final updatedUser = User.fromJson(response.data);
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
