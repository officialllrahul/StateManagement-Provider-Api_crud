import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:statemanagementflutter/PostmanApi/FakeStoreApi/dataModel.dart';
import 'package:statemanagementflutter/PostmanApi/FakeStoreApi/providers.dart';

class fakeStore extends StatefulWidget {
  const fakeStore({super.key});

  @override
  State<fakeStore> createState() => _fakeStoreState();
}

class _fakeStoreState extends State<fakeStore> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureProvider<List<FakeProductDataModel>>(
        create: (_) => FakeProductProvider().fetchFakeProduct(),
        catchError: (_, error) {
          print('Error fetching data: $error');
          return [];
        },
        initialData: [],
        child: Consumer<List<FakeProductDataModel>>(
          builder: (context, itemList, _) {
            if (itemList == null) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return ListView.builder(
                itemCount: itemList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(itemList[index].title),
                    subtitle: Text(itemList[index].description),
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
