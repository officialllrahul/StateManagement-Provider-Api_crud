import 'package:flutter/material.dart';
import 'package:statemanagementflutter/PostmanApi/Items/itemapi.dart';
import 'package:statemanagementflutter/PostmanApi/Users/usersApi.dart';

class postManApi extends StatefulWidget {
  const postManApi({super.key});

  @override
  State<postManApi> createState() => _postManApiState();
}

class _postManApiState extends State<postManApi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => postManItems()),
              );
            }, child: const Text("Postman Items API")),
            ElevatedButton(onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PostManUsers()),
              );
            }, child: const Text("Postman Users API"))
          ],
        ),
      ),
    );
  }
}
