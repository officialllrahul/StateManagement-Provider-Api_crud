import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:statemanagementflutter/PostmanApi/FakeStoreApi/dataModel.dart';
import 'package:http/http.dart' as http;

class FakeProductProvider with ChangeNotifier {
  String url = "https://fakestoreapi.com/products";

  Future<List<FakeProductDataModel>> fetchFakeProduct() async {
    try {
      var response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        dynamic data = jsonDecode(response.body);

        if (data is List) {
          List<FakeProductDataModel> dataList = data
              .map((product) => FakeProductDataModel.fromJson(product))
              .toList();
          return dataList;
        } else {
          var product = FakeProductDataModel.fromJson(data);
          return [product];
        }
      } else {
        throw Exception('Failed to load fake products');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }
}
