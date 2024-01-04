import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import 'DataModel.dart';


class StreamProfileService extends ChangeNotifier {

  Stream<List<UserProfile>> getUsersLists( ){

    var users = FirebaseFirestore.instance.collection("UsersData").snapshots();
    var userList= users.map((event) => event.docs.map((doc) => UserProfile.fromJson(doc.data())).toList());
    return userList;
  }

}