import 'package:firebase_demo3/core/constants/color_constants.dart';
import 'package:firebase_demo3/core/constants/string_constants.dart';
import 'package:firebase_demo3/core/utils/validation_utils.dart';
import 'package:firebase_demo3/core/viewmodels/login_view_model.dart';
import 'package:firebase_demo3/ui/views/base_view.dart';
import 'package:firebase_demo3/ui/widgets/common_elevated_button.dart';
import 'package:firebase_demo3/ui/widgets/common_textformfied.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

// ignore: must_be_immutable
class LoginView extends StatelessWidget {
  LoginView({super.key});
  late LoginViewModel model;

  @override
  Widget build(BuildContext context) {
    return BaseView<LoginViewModel>(
      onModelReady: (model) {
        this.model = model;
        SchedulerBinding.instance.addPostFrameCallback((_) {
          // model.getData();
        });
      },
      builder: (context, model, child) {
        return loginMethod(context);
      },
    );
  }

  SafeArea loginMethod(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Form(
        key: model.formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(children: [
              const SizedBox(
                height: 50,
              ),
              Text(
                StringConstants.login,
                style: TextStyle(
                    color: ColorConstant.black,
                    fontSize: 25,
                    fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 50,
              ),
              TextFormFieldWidget(
                textInputType: TextInputType.emailAddress,
                label: StringConstants.email,
                hintText: StringConstants.emailHint,
                controller: model.emailController,
                validator: (value) {
                  return Validations.isEmailValid(value.toString());
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormFieldWidget(
                  obscureText: true,
                  textInputType: TextInputType.name,
                  label: StringConstants.pass,
                  hintText: StringConstants.passHint,
                  validator: (value) {
                    return Validations.isPassValid(value.toString());
                  },
                  controller: model.passController),
              const SizedBox(
                height: 40,
              ),
              ElevatedButtonWidget(
                btnText: StringConstants.login,
                onpress: () {
                  model.onPressLogin(context);
                },
              )
            ]),
          ),
        ),
      ),
    ));
  }
}
