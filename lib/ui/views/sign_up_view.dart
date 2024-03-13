import 'package:firebase_demo3/core/constants/color_constants.dart';
import 'package:firebase_demo3/core/constants/image_constants.dart';
import 'package:firebase_demo3/core/constants/string_constants.dart';
import 'package:firebase_demo3/core/utils/validation_utils.dart';
import 'package:firebase_demo3/core/viewmodels/sign_up_view_model.dart';
import 'package:firebase_demo3/ui/views/base_view.dart';
import 'package:firebase_demo3/ui/widgets/common_elevated_button.dart';
import 'package:firebase_demo3/ui/widgets/common_textformfied.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

// ignore: must_be_immutable
class SignInView extends StatelessWidget {
  SignInView({super.key});

  late SignUpViewModel model;
  @override
  Widget build(BuildContext context) {
    return BaseView<SignUpViewModel>(onModelReady: (model) {
      this.model = model;
      SchedulerBinding.instance.addPostFrameCallback((_) {});
    }, builder: (context, model, child) {
      return signUpMethod(context);
    });
  }

  SafeArea signUpMethod(BuildContext context) {
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
                StringConstants.signUp,
                style: TextStyle(
                    color: ColorConstant.black,
                    fontSize: 25,
                    fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 50,
              ),
              TextFormFieldWidget(
                textInputType: TextInputType.name,
                label: StringConstants.name,
                hintText: StringConstants.nameHint,
                controller: model.nameController,
                validator: (value) {
                  return Validations.isNameValid(value.toString());
                },
              ),
              const SizedBox(
                height: 20,
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
                textInputType: TextInputType.number,
                label: StringConstants.phoneNo,
                hintText: StringConstants.phoneNoHint,
                controller: model.phoneNoController,
                validator: (value) {
                  return Validations.isPhoneNoValid(value.toString());
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
                height: 20,
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 4),
                    child: Text(
                      StringConstants.gender,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  addRadioButton(0, 'Male'),
                  addRadioButton(1, 'Female'),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              ElevatedButtonWidget(
                btnText: StringConstants.signUp,
                onpress: () {
                  model.onPressSignUp(context);
                },
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: ColorConstant.black),
                  onPressed: () {
                    model.onPressGoogleSignIn(context);
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          StringConstants.googleSignIn,
                          style: TextStyle(
                              color: ColorConstant.white, fontSize: 16),
                        ),
                      ),
                      Image.asset(
                        ImageConstant.googleIcons,
                        fit: BoxFit.contain,
                      ),
                    ],
                  )),
            ]),
          ),
        ),
      ),
    ));
  }

  addRadioButton(int btnValue, String title) {
    return Flexible(
      fit: FlexFit.loose,
      child: RadioListTile(
        activeColor: ColorConstant.black,
        title: Text(title),
        value: model.genderList[btnValue],
        groupValue: model.gender,
        onChanged: (value) {
          model.changeGender(value);
        },
      ),
    );
  }
}
