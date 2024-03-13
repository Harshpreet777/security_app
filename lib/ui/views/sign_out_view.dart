import 'package:firebase_demo3/core/constants/color_constants.dart';
import 'package:firebase_demo3/core/constants/image_constants.dart';
import 'package:firebase_demo3/core/viewmodels/sign_out_view_model.dart';
import 'package:firebase_demo3/ui/views/base_view.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SignOutView extends StatelessWidget {
  SignOutView({super.key});
  SignOutViewModel? model;

  @override
  Widget build(BuildContext context) {
    return BaseView<SignOutViewModel>(
      onModelReady: (model) {
        this.model = model;
      },
      builder: (context, model, child) {
        return signOutMethod(context);
      },
    );
  }

  Center signOutMethod(BuildContext context) {
    return Center(
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: ColorConstant.black),
          onPressed: () {
            model?.signOut(context);
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  'SignOut With Google',
                  style: TextStyle(color: ColorConstant.white, fontSize: 16),
                ),
              ),
              Image.asset(
                ImageConstant.googleIcons,
                fit: BoxFit.contain,
              ),
            ],
          )),
    );
  }
}
