import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:statemanagementflutter/PostmanApi/Users/usersDataModel.dart';
import 'package:statemanagementflutter/PostmanApi/Users/usersProvider.dart';

class PostManUsers extends StatelessWidget {
  const PostManUsers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your App'),
      ),
      body: FutureBuilder(
        future: Provider.of<RazorPayCustomerProvider>(context).getCustomerList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else {
            if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else {
              return Consumer<RazorPayCustomerProvider>(
                builder: (context, provider, child) {
                  if (provider.customerModel == null) {
                    return const Text('No data available');
                  }
                  return ListView.builder(
                    itemCount: provider.customerModel!.items.length,
                    itemBuilder: (context, index) {
                      Item item = provider.customerModel!.items[index];
                      return ListTile(
                        title: Text(item.name ?? 'No Name'),
                        subtitle: Text(item.email ?? 'No Email'),
                      );
                    },
                  );
                },
              );
            }
          }
        },
      ),
    );
  }
}

