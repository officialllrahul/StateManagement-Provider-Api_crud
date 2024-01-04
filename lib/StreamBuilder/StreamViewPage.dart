import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:statemanagementflutter/StreamBuilder/streamProvider.dart';
import 'DataModel.dart';

class StreamProviderPage extends StatefulWidget {
  const StreamProviderPage({super.key});

  @override
  State<StreamProviderPage> createState() => _StreamProviderPageState();
}

class _StreamProviderPageState extends State<StreamProviderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold ( // Wrap with Scaffold
      appBar: AppBar(
        title: Text('Your App Title'),
      ),
      body: MultiProvider(
        providers: [
          StreamProvider(create: (context) => StreamProfileService().getUsersLists(), initialData: <UserProfile>[],)
        ],
        child: Container(
          height: 500,
          child: Consumer<List<UserProfile>>(builder: (context, value, child) {
            if (value.isEmpty) {
              return Text("No Records Found");
            }
            return ListView.builder(
              itemCount: value.length,
              itemBuilder: (context, index) {
                var userData = value[index];
                return ListTile(
                  title: Text(userData.name.toString()),
                );
              },
            );
          }),
        ),
      ),
    );
  }
}
