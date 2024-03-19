import 'package:flutter/material.dart';

class MyTextFormField extends StatelessWidget {
  String hintText;
  TextEditingController controller;
  TextInputType inputType;
  bool obscureText;
  FocusNode? focusNode;
  var onFieldSubmitted;
  var validator;
  MyTextFormField({
    super.key,
    required this.hintText,
    required this.controller,
    required this.inputType,
    required this.obscureText,
    this.focusNode,
    this.onFieldSubmitted,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width * 1;

    OutlineInputBorder my_border = OutlineInputBorder(
      borderSide: Divider.createBorderSide(context),
    );
    return TextFormField(
      focusNode: focusNode,
      onFieldSubmitted: onFieldSubmitted,
      controller: controller,
      obscureText: obscureText,
      validator: validator,
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
