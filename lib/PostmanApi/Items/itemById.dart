import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:statemanagementflutter/PostmanApi/Items/itemDataModel.dart';

class ItemsById extends StatelessWidget {
  const ItemsById({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureProvider<Item?>(
        create: (_) => fetchData(),
        catchError: (_, error) {
          print('Error fetching data: $error');
          return null;
        },
        initialData: null,
        child: Consumer<Item?>(
          builder: (context, item, _) {
            if (item == null) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return ListTile(
                subtitle: Column(
                  children: [
                    const SizedBox(height: 200,),
                    Text(item.name.toString()),
                    Text(item.amount.toString()),
                    Text(item.description.toString()),
                    Text(item.unitAmount.toString()),
                    Text(item.currency.toString())
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Future<Item> fetchData() async {
    String username = 'rzp_test_0vTkYp1eevPEon';
    String password = 'X1TgHQwfXo6iZRQIBn2lqlcF';
    String basicAuth =
        'Basic ${base64Encode(utf8.encode('$username:$password'))}';
    final response = await http.get(
      Uri.parse('https://api.razorpay.com/v1/items/item_NMO7eHpEdyR49Y'),
      headers: {"Authorization": basicAuth},
    );
    if (response.statusCode == 200) {
      dynamic data = json.decode(response.body);
      Item item = Item.fromJson(data);
      return item;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
