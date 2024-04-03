import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_demo3/core/models/user_model.dart';

class DataBaseService {
  final String? uid;
  DataBaseService({this.uid});
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('Users');
  Future<bool> getEmail(String email) async {
    try {
      final querySnapshot =
          await userCollection.where('email', isEqualTo: email).get();
      UserModel allData =
          querySnapshot.docs.map((e) => UserModel.fromJson(e)).single;
      log(allData.toString());
      return true;
    } catch (e) {
      log('Email does not Exist');
      return false;
    }
  }

  Future<UserModel> getUserData(
    String email,
    String pass,
  ) async {
    UserModel allData;
    final querySnapshot = await userCollection
        .where(
          'email',
          isEqualTo: email,
        )
        .get();
    allData = querySnapshot.docs.map((e) => UserModel.fromJson(e)).single;
    
    if (allData.email != email) {
      log('Email does not Exist');
    }
    return allData;
  }

  Future<UserModel> getUpdatedUserData(String uid) async {
    UserModel allData;
    final querySnapshot = await userCollection
        .where(
          'uid',
          isEqualTo: uid,
        )
        .get();
    allData = querySnapshot.docs.map((e) => UserModel.fromJson(e)).single;

    return allData;
  }

  Future setuserDetails(UserModel userModel) async {
    return await userCollection.doc(uid).set(userModel.toJson());
  }

  Future updateUserDetails(UserModel userModel) async {
    return await userCollection.doc(uid).update(userModel.toJson());
  }
}
