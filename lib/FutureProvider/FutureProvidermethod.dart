import 'package:flutter/cupertino.dart';

class FutureDataService extends ChangeNotifier {

  Future<String> getDetails() async {
    await Future.delayed(const Duration(seconds: 20));
    return "Rahul";
  }
}


