import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_demo3/model/user_model.dart';

class DataBaseService {
  final String uid;
  DataBaseService({required this.uid});
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('Users');

  Future updateUserData(UserModel userModel) async {
    return await userCollection
        .doc(uid)
        .set({'email': userModel.email, 'password': userModel.pass});
  }
}
