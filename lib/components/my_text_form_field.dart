import 'package:flutter/material.dart';

class MyTextFormField extends StatelessWidget {
  String hintText;
  TextEditingController controller;
  TextInputType inputType;
  bool obscureText;
  MyTextFormField({
    super.key,
    required this.hintText,
    required this.controller,
    required this.inputType,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width * 1;

    OutlineInputBorder my_border = OutlineInputBorder(
      borderSide: Divider.createBorderSide(context),
    );
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(width * 0.035),
        hintText: hintText,
        border: my_border,
        enabledBorder: my_border,
        focusedBorder: my_border,
        filled: true,
      ),
      keyboardType: inputType,
    );
  }
}
