import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svgst.dart';
import 'package:instagram_clone_firebase/utils/colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height * 1;
    double width = MediaQuery.of(context).size.width * 1;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: SvgPicture.asset(
          'assets/images/instagram_logo.svg',
          color: primaryColor,
        ),
        centerTitle: false,
        actions: [
          Icon(
            Icons.messenger,
          ),
          SizedBox(
            width: width * 0.02,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
