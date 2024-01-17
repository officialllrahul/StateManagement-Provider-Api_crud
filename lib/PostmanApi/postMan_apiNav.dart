import 'package:flutter/material.dart';
import 'package:statemanagementflutter/PostmanApi/FakeStoreApi/UserInterface.dart';
import 'package:statemanagementflutter/PostmanApi/Items/item.dart';
import 'package:statemanagementflutter/PostmanApi/Items/itemById.dart';
import 'package:statemanagementflutter/PostmanApi/Task/movieScreen.dart';
import 'package:statemanagementflutter/PostmanApi/Users/customerById.dart';
import 'package:statemanagementflutter/PostmanApi/Users/usersApi.dart';
import 'package:statemanagementflutter/PostmanApi/razorPayIntergration.dart';

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
                MaterialPageRoute(builder: (context) => itemsHomepage()),
              );
            }, child: const Text("Postman Items API")),
            ElevatedButton(onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CustomerHomePage()),
              );
            }, child: const Text("Postman Users API")),
            ElevatedButton(onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const customerById()),
              );
            }, child: const Text("Postman Users(By Id)")),
            ElevatedButton(onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ItemsById()),
              );
            }, child: const Text("Postman Items(By Id)")),
            ElevatedButton(onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyHomePage()),
              );
            }, child: const Text("Razorpay Payment Gateway")),
            ElevatedButton(onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MovieScreen()),
              );
            }, child: const Text("Movie Screen")),
            ElevatedButton(onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => fakeStore()),
              );
            }, child: const Text("Fake product")),
          ],
        ),
      ),
    );
  }
}
