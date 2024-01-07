import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'itemDataModel.dart';

class ItemProvider with ChangeNotifier {
  List<Item> _items = [];

  List<Item> get items => _items;

  Future<void> fetchItems() async {
    final response = await http.get(Uri.parse('https://api.razorpay.com/v1/items'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      _items = data.map((itemJson) => Item.fromJson(itemJson)).toList();
      notifyListeners();
    } else {
      throw Exception('Failed to load items');
    }
  }
}