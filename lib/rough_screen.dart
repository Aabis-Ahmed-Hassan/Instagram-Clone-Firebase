import 'package:flutter/material.dart';

class RoughScreen extends StatelessWidget {
  var i;
  RoughScreen({super.key, required this.i});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Text(
        i.toString(),
        style: TextStyle(
          fontSize: 50,
          color: Colors.white,
        ),
      ),
    ));
  }
}
