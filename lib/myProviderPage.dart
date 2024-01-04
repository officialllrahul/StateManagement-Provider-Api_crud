import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:statemanagementflutter/DataModel.dart';

class HomePageProvider with ChangeNotifier {

  String UserName = "";
  int count = 0;


  void SetUserName(String name) {
    UserName = name;
    notifyListeners();
  }

  String getData() {
    count++;
    return count.toString();
  }

}


class UserProfileService extends ChangeNotifier {
  CollectionReference _userProfileCollection =
  FirebaseFirestore.instance.collection('UsersData');

  List<UserProfileData> _userProfiles = [];

  List<UserProfileData> get userProfiles => _userProfiles;

  Future<void> fetchUserProfiles() async {
    try {
      QuerySnapshot querySnapshot = await _userProfileCollection.get();
      _userProfiles = querySnapshot.docs
          .map((doc) => UserProfileData.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
      notifyListeners();
    } catch (error) {
      print("Error fetching user profiles: $error");
    }
  }
}

class OrderProductService extends ChangeNotifier {
  CollectionReference _ordersCollection =
  FirebaseFirestore.instance.collection('ProductData');

  List<OrderProduct> _orderProducts = [];

  List<OrderProduct> get orderProducts => _orderProducts;

  Future<void> fetchOrderProducts() async {
    try {
      QuerySnapshot querySnapshot = await _ordersCollection.get();
      _orderProducts = querySnapshot.docs
          .map((doc) =>
          OrderProduct.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
      notifyListeners();
    } catch (error) {
      print("Error fetching order products: $error");
    }
  }
}

class CustomerService extends ChangeNotifier {
  CollectionReference _customerCollection =
  FirebaseFirestore.instance.collection('CustomerData');

  List<CustomerData> _customerProfile = [];

  List<CustomerData> get customerProfile => _customerProfile;

  Future<void> fetchCustomerProfiles() async {
    try {
      QuerySnapshot querySnapshot = await _customerCollection.get();
      _customerProfile = querySnapshot.docs
          .map((doc) => CustomerData.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
      notifyListeners();
    } catch (error) {
      print("Error fetching user profiles: $error");
    }
  }
}