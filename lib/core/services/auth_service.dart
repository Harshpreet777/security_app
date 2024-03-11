// import 'dart:developer';

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_demo3/model/user_model.dart';
// import 'package:firebase_demo3/services/database_service.dart';
// import 'package:firebase_demo3/utils/string_constants.dart';

// class Auth {
//   final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
//   User? get currentUser => _firebaseAuth.currentUser;
//   Future<User?> signUpWithEmailAndPassword(
//       String email, String name, String phoneNo) async {
//     try {
//       UserCredential userCredential =
//           await _firebaseAuth.createUserWithEmailAndPassword(
//         email: email,
//         password: name,
//       );
//       await DataBaseService(uid: userCredential.user?.uid ?? '').updateUserData(
//           UserModel(email: email, name: name, phoneNo: phoneNo));
//       return userCredential.user;
//     } on FirebaseAuthException catch (e) {
//       if (e.code.toString() == StringConstants.emailAlready) {
//         log('User Already exists');
//       } else {
//         log('Error is $e');
//       }
//     }
//     return null;
//   }

//   Future<User?> signInWithEmailAndPassword(
//       String email, String password) async {
//     try {
//       UserCredential userCredential = await _firebaseAuth
//           .signInWithEmailAndPassword(email: email, password: password);
//       return userCredential.user;
//     } catch (e) {
//       log('Error is $e');
//     }
//     return null;
//   }

//   Future<void> signOut() async {
//     await _firebaseAuth.signOut();
//   }
// }
