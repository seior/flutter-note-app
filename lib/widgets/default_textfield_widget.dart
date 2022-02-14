import 'dart:ffi';

import 'package:flutter/material.dart';

class DefaultTextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final FontWeight fontWeight;
  final double textSize;

  const DefaultTextFieldWidget({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.fontWeight,
    required this.textSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: 1,
      decoration: InputDecoration(
        hintText: hintText,
        border: InputBorder.none,
      ),
      style: TextStyle(
        color: Colors.black,
        fontWeight: fontWeight,
        fontSize: textSize,
      ),
    );
  }
}
