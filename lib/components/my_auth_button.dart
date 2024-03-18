import 'package:flutter/material.dart';
import 'package:instagram_clone_firebase/utils/colors.dart';

class MyAuthButton extends StatelessWidget {
  VoidCallback onTap;

  String title;

  MyAuthButton({
    super.key,
    required this.onTap,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height * 1;
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height * 0.055,
        width: double.infinity,
        decoration: BoxDecoration(
          color: blueColor,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}
