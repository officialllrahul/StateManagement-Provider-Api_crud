import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:statemanagementflutter/PostmanApi/Users/usersDataModel.dart';

class RazorPayCustomerProvider extends ChangeNotifier {
  RazorPayCustomerModel? _customerModel;
  RazorPayCustomerModel? get customerModel => _customerModel;

  Future<void> getCustomerList() async {
    try {
      String userName = "rzp_test_sRg3Md9vCNGVki";
      String password = "VsOAz2Z0uxWeQyztSjNIa7G4";
      String basicAuth = "Basic ${base64Encode(utf8.encode('$userName:$password'))}";
      var res = await http.get(
        Uri.parse("https://api.razorpay.com/v1/customers"),
        headers: {'Authorization': basicAuth},
      );

      if (res.statusCode == 200) {
        dynamic body = jsonDecode(res.body);
        _customerModel = RazorPayCustomerModel.fromJson(body);
        notifyListeners();
      } else {
        // Print error details
        print('HTTP Error: ${res.statusCode}');
        print('Response Body: ${res.body}');
      }
    } catch (e, stackTrace) {
      // Handle other exceptions
      print('Error: $e');
      print('Stack Trace: $stackTrace');
    }
  }

}
