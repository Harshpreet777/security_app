import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_demo3/core/models/user_model.dart';
import 'package:firebase_demo3/core/services/database_service.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuth {
  Future<bool> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);
      log(googleUser.toString());
      await DataBaseService(uid: googleUser?.id).setuserDetails(UserModel(
          uid: googleUser?.id ?? '',
          email: googleUser?.email ?? '',
          name: googleUser?.displayName ?? '',
          phoneNo: '',
          image: googleUser?.photoUrl ?? '',
          pass: 'Harsh@12',
          gender: 'Male'));
      await FirebaseAuth.instance.signInWithCredential(credential);
      return true;
    } catch (e) {
      log('Error is $e');
      return false;
    }
  }

  Future<bool> signOutFromGoogle() async {
    try {
      await FirebaseAuth.instance.signOut();
      GoogleSignIn().disconnect();
      return true;
    } on Exception catch (e) {
      log("Error is $e");
      return false;
    }
  }
}
