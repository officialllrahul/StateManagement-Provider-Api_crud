import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'itemProvider.dart';

class postManItems extends StatelessWidget {
  const postManItems({super.key});

  @override
  Widget build(BuildContext context) {
    final itemProvider = Provider.of<ItemProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Item List'),
      ),
      body: FutureBuilder(
        future: itemProvider.fetchItems(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return ListView.builder(
              itemCount: itemProvider.items.length,
              itemBuilder: (context, index) {
                final item = itemProvider.items[index];
                return ListTile(
                  title: Text(item.name),
                  subtitle: Text('Price: \$${item.price}'),
                );
              },
            );
          }
        },
      ),
    );
  }
}
