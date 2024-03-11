import 'package:firebase_demo3/core/constants/color_constants.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ElevatedButtonWidget extends StatelessWidget {
  ElevatedButtonWidget(
      {super.key, required this.btnText, required this.onpress});
  String btnText;
  final VoidCallback? onpress;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
          onPressed: onpress,
          style: ElevatedButton.styleFrom(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              backgroundColor: ColorConstant.black),
          child: Text(
            btnText,
            style: TextStyle(color: ColorConstant.white, fontSize: 20),
          )),
    );
  }
}
