import 'package:firebase_demo3/core/constants/color_constants.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TextFormFieldWidget extends StatelessWidget {
  TextFormFieldWidget(
      {super.key,
      required this.textInputType,
      required this.label,
      this.hintText,
      required this.validator,
      required this.controller,
      this.obscureText});
  String label;
  String? hintText;
  final String? Function(String?)? validator;
  TextEditingController controller;
  TextInputType textInputType;
  bool? obscureText = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      obscuringCharacter: '*',
      obscureText: obscureText ?? false,
      keyboardType: textInputType,
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          label: Text(
            label,
            style: TextStyle(color: ColorConstant.black),
          ),
          fillColor: ColorConstant.white,
          filled: true,
          hintText: hintText,
          hintStyle: TextStyle(
            color: ColorConstant.black54,
          ),
          border: const OutlineInputBorder(
              borderSide: BorderSide(),
              borderRadius: BorderRadius.all(Radius.circular(8))),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(8))),
          errorBorder: const OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(8)))),
    );
  }
}
