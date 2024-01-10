import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:statemanagementflutter/PostmanApi/Users/usersDataModel.dart';

class customerById extends StatelessWidget {
  const customerById({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureProvider<List<Item>?>(
        create: (_) => fetchData(),
        catchError: (_, error) {
          print('Error fetching data: $error');
          return null;
        },
        initialData: null,
        child: Consumer<List<Item>?>(
          builder: (context, items, _) {
            if (items == null || items.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  Item currentItem = items[index];
                  return ListTile(
                    title: Text(currentItem.name.toString()),
                    subtitle: Text(currentItem.email.toString()),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }

  Future<List<Item>> fetchData() async {
    String username = 'rzp_test_0vTkYp1eevPEon';
    String password = 'X1TgHQwfXo6iZRQIBn2lqlcF';
    String basicAuth = 'Basic ${base64Encode(utf8.encode('$username:$password'))}';
    final response = await http.get(
      Uri.parse('https://api.razorpay.com/v1/customers/cust_NM4OxXbRWN5rIU'),
      headers: {"Authorization": basicAuth},
    );
    if (response.statusCode == 200) {
      dynamic data = json.decode(response.body);
      List<Item> itemList = [Item.fromJson(data)];
      return itemList;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
