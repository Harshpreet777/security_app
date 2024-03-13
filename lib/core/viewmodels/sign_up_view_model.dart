import 'dart:math';

import 'package:firebase_demo3/core/models/user_model.dart';
import 'package:firebase_demo3/core/routing/routes.dart';
import 'package:firebase_demo3/core/services/database_service.dart';
import 'package:firebase_demo3/core/services/google_auth.dart';
import 'package:firebase_demo3/core/viewmodels/base_model.dart';
import 'package:flutter/material.dart';

class SignUpViewModel extends BaseModel {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passController = TextEditingController();

  final TextEditingController phoneNoController = TextEditingController();

  final TextEditingController nameController = TextEditingController();

  String image = '';

  List genderList = ["Male", "Female"];

  String gender = 'Male';

  changeGender(var value) {
    gender = value;
    updateUI();
  }

  Future getUserEmail() async {
    return await DataBaseService().getEmail(emailController.text);
  }

  void onPressGoogleSignIn(BuildContext context) async {
    bool isSignIn = await GoogleAuth().signInWithGoogle();
    updateUI();
    if (isSignIn == true) {
      
      if (context.mounted) {
        Navigator.of(context).pushNamed(Routes.sighOutRoute);
      }
    }
    else{
      debugPrint('Not Sign In');
    }
  }

  void onPressSignUp(BuildContext context) async {
    var rng = Random();
    String uid = "";
    for (int i = 0; i < 2; i++) {
      uid += rng.nextInt(1000000).toString();
    }
    String email = emailController.text;
    String name = nameController.text;
    String phoneNo = phoneNoController.text;
    String pass = passController.text;
    if (formKey.currentState?.validate() ?? false) {
      bool isUserExist = await getUserEmail();
      if (isUserExist == false) {
        await DataBaseService(uid: uid).setuserDetails(UserModel(
            uid: uid,
            email: email,
            name: name,
            phoneNo: phoneNo,
            image: image,
            pass: pass,
            gender: gender));
        if (context.mounted) {
          Navigator.of(context).pushNamed(Routes.loginRoute);
        }
      } else {
        if (context.mounted) {
          showDialog<String>(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) => AlertDialog(
                    title: const Text('User Exists'),
                    content: const Text('Email Already Exists'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context, 'OK');
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  ));
        }
      }
    }
  }
}
