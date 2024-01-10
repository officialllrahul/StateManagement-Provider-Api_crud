import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:statemanagementflutter/PostmanApi/Items/itemDataModel.dart';
import 'itemProvider.dart';

class PostManItems extends StatelessWidget {
  const PostManItems({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final itemProvider = Provider.of<RazorPayItemsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Item List'),
      ),
      body: FutureProvider<List<Item>>(
        create: (_) => itemProvider.fetchData(),
        catchError: (_, error) {
          print('Error fetching data: $error');
          return [];
        },
        initialData: [],
        child: Consumer<List<Item>>(
          builder: (context, items, _) {
            if (items.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  Item currentItem = items[index];
                  return ListTile(
                    subtitle: Column(
                      children: [
                        Text(currentItem.name.toString()),
                        Text(currentItem.amount.toString()),
                        Text(currentItem.description.toString()),
                        Text(currentItem.unitAmount.toString()),
                        Text(currentItem.currency.toString())
                      ],
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
