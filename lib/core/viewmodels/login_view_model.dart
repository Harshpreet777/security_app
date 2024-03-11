import 'dart:developer';

import 'package:firebase_demo3/core/models/user_model.dart';
import 'package:firebase_demo3/core/routing/routes.dart';
import 'package:firebase_demo3/core/services/database_service.dart';
import 'package:firebase_demo3/core/viewmodels/base_model.dart';
import 'package:flutter/material.dart';

class LoginViewModel extends BaseModel {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passController = TextEditingController();
  Future getData() async {
    return await DataBaseService()
        .getUserData(emailController.text, passController.text);
  }

  void onPressLogin(BuildContext context) async {
    if (formKey.currentState?.validate() ?? false) {
      try {
        UserModel data = await getData();
        if (context.mounted) {
          Navigator.of(context)
              .pushNamed(Routes.updateProfileRoute, arguments: data);
        }
      } catch (e) {
        log('Email or Password does not Exist');
      }
    }
  }
}
