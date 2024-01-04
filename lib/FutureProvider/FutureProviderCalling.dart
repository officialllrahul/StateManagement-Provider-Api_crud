import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:statemanagementflutter/FutureProvider/FutureProvidermethod.dart';

class FutureProviderPage extends StatelessWidget {
  const FutureProviderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      FutureProvider(create: (context)=>FutureDataService().getDetails(), initialData: "Raj"),
    ],
      child: Center(
        child: ListView(
          children: [
            Consumer<String>(builder: (context,value,child)=> Text(value,style:const TextStyle(color: Colors.blue)))
          ],
        ),
      )
    );
  }
}
