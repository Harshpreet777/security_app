import 'package:firebase_demo3/core/constants/color_constants.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CommonStackWidget extends StatelessWidget {
  CommonStackWidget({super.key, required this.onpress, required this.widget});
  final VoidCallback? onpress;
  Widget widget;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
            decoration: BoxDecoration(
                color: ColorConstant.white,
                borderRadius: const BorderRadius.all(Radius.circular(100))),
            width: 130,
            height: 130,
            child: widget),
        Positioned(
          bottom: -10,
          right: 0,
          child: Container(
            decoration: BoxDecoration(
                color: ColorConstant.white,
                borderRadius: const BorderRadius.all(Radius.circular(50))),
            child: IconButton(
                onPressed: onpress,
                icon: Icon(
                  Icons.edit,
                  color: ColorConstant.black,
                )),
          ),
        )
      ],
    );
  }
}
