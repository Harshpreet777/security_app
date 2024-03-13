import 'package:firebase_demo3/core/services/google_auth.dart';
import 'package:firebase_demo3/core/viewmodels/base_model.dart';
import 'package:flutter/widgets.dart';

class SignOutViewModel extends BaseModel {
  Future signOut(BuildContext context) async {
    await GoogleAuth().signOutFromGoogle();

    updateUI();
    if (context.mounted) {
      Navigator.pop(context);
    }
  }
}
