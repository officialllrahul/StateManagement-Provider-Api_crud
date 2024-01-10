import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'itemDataModel.dart';

class RazorPayItemsProvider with ChangeNotifier {
  List<Item> _items = [];

  List<Item> get items => List<Item>.from(_items);

  Future<List<Item>> fetchData() async {
    String username = 'rzp_test_0vTkYp1eevPEon';
    String password = 'X1TgHQwfXo6iZRQIBn2lqlcF';
    String basicAuth =
        'Basic ${base64Encode(utf8.encode('$username:$password'))}';
    final response = await http.get(
      Uri.parse('https://api.razorpay.com/v1/items'),
      headers: {"Authorization": basicAuth},
    );
    if (response.statusCode == 200) {
      dynamic data = json.decode(response.body);
      List<dynamic> items = data['items'];
      var itemList = items.map((e) => Item.fromJson(e)).toList();
      return itemList;
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<Item> createItems(String name, String description, int amount) async {
    try {
      String username = 'rzp_test_0vTkYp1eevPEon';
      String password = 'X1TgHQwfXo6iZRQIBn2lqlcF';
      String basicAuth =
          'Basic ${base64Encode(utf8.encode('$username:$password'))}';
      final response = await http.post(
        Uri.parse('https://api.razorpay.com/v1/items'),
        headers: {
          "Authorization": basicAuth,
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "name": name,
          "description": description,
          "amount": amount,
          "currency": 'INR',
          // Add other required fields here...
        }),
      );
      if (response.statusCode == 200) {
        dynamic data = json.decode(response.body);
        Item newItem = Item.fromJson(data);
        // Notify listeners or update the state as needed
        notifyListeners();
        Fluttertoast.showToast(
            msg: "User Created Successfully",
            toastLength: Toast.LENGTH_SHORT,
            fontSize: 16.0);
        return newItem;
      } else {
        throw Exception(
            'Failed to create customer. Status Code: ${response.statusCode}, Body: ${response.body}');
      }
    } catch (e) {
      // Handle errors
      print('Error in createCustomer: $e');
      throw Exception('Failed to create customer: $e');
    }
  }

  Future<Item> updateItem(String itemId, String newName, String newDescription, int amount) async {
    try {
      String username = 'rzp_test_0vTkYp1eevPEon';
      String password = 'X1TgHQwfXo6iZRQIBn2lqlcF';
      String basicAuth =
          'Basic ${base64Encode(utf8.encode('$username:$password'))}';

      final response = await http.patch(
        Uri.parse('https://api.razorpay.com/v1/items/$itemId'),
        headers: {
          "Authorization": basicAuth,
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "amount": amount,
          "name": newName,
          "description": newDescription,
          "currency": 'INR'
        }),
      );

      if (response.statusCode == 200) {
        dynamic data = json.decode(response.body);
        Item updatedItem = Item.fromJson(data);
        // Notify listeners or update the state as needed
        Fluttertoast.showToast(
            msg: "Data updated successfully",
            toastLength: Toast.LENGTH_SHORT,
            fontSize: 16.0);
        notifyListeners();
        return updatedItem;
      } else {
        throw Exception(
            'Failed to update customer. Status Code: ${response.statusCode}, Body: ${response.body}');
      }
    } catch (e) {
      print('Error in updateCustomer: $e');
      throw Exception('Failed to update customer: $e');
    }
  }

  Future<void> deleteItem(String itemId) async {
    try {
      String username = 'rzp_test_0vTkYp1eevPEon';
      String password = 'X1TgHQwfXo6iZRQIBn2lqlcF';
      String basicAuth =
          'Basic ${base64Encode(utf8.encode('$username:$password'))}';

      final response = await http.delete(
        Uri.parse('https://api.razorpay.com/v1/items/$itemId'),
        headers: {
          "Authorization": basicAuth,
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        Fluttertoast.showToast(
          msg: "Item deleted successfully",
          toastLength: Toast.LENGTH_SHORT,
        );
        notifyListeners();
      } else {
        throw Exception(
            'Failed to delete customer. Status Code: ${response.statusCode}, Body: ${response.body}');
      }
    } catch (e) {
      print('Error in deleteCustomer: $e');
      throw Exception('Failed to delete customer: $e');
    }
  }
}
