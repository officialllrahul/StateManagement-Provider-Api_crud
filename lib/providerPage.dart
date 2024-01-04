import 'package:flutter/material.dart';
import 'package:statemanagementflutter/myProviderPage.dart';
import 'package:provider/provider.dart';

class providerPage extends StatefulWidget {
  const providerPage({super.key});

  @override
  State<providerPage> createState() => _providerPageState();
}

class _providerPageState extends State<providerPage> {
  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Single consumer provider
      // body: ChangeNotifierProvider<HomePageProvider>(create: (context) => HomePageProvider(),
      //   child: Consumer<HomePageProvider>(
      //     builder: (context, value, child) => ListView(
      //       children: [
      //         TextField(
      //           controller: nameController,
      //           decoration: const InputDecoration(hintText: "Enter name"),
      //           onChanged: (changedValue){
      //             value.SetUserName(changedValue);
      //           },
      //         ),
      //         ElevatedButton(onPressed: (){
      //           value.SetUserName(nameController.text);
      //         }, child: const Text("Show now")),
      //         Text(value.UserName,style: const TextStyle(color: Colors.black,fontSize: 30),)
      //       ],
      //     ),
      //   ),
      //
      // ),
      body: ChangeNotifierProvider<HomePageProvider>(
        create: (context) => HomePageProvider(),
        child: ListView(
          children: [
            Container(
              height: 100,
              color: Colors.red,
              alignment: Alignment.center,
              child: const Text(
                "Provider",
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
            ),
            SizedBox(
              height: 200,
              child: Consumer<HomePageProvider>(
                builder: (context, value, child) => ListView(
                  children: [
                    TextField(
                      controller: nameController,
                      decoration: const InputDecoration(hintText: "Enter name"),
                      onChanged: (changedValue) {
                        value.SetUserName(changedValue);
                      },
                    ),
                    ElevatedButton(
                        onPressed: () {
                          value.SetUserName(nameController.text);
                        },
                        child: const Text("Show now")),
                    Text(
                      value.UserName,
                      style: const TextStyle(color: Colors.black, fontSize: 30),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 300,
              child: Consumer<HomePageProvider>(
                builder: (context, value, child) => Text(
                  value.getData(),
                  style: const TextStyle(fontSize: 30),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
