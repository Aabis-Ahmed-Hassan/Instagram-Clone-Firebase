import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone_firebase/utils/Routes/route_names.dart';
import 'package:instagram_clone_firebase/utils/utils.dart';

class RoughScreen extends StatelessWidget {
  var i;
  RoughScreen({super.key, required this.i});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: InkWell(
        onTap: () {
          FirebaseAuth.instance.signOut().then((value) {
            Navigator.pushNamed(context, RouteNames.login);
          }).onError((error, stackTrace) {
            Utils.showToastMessage(error.toString());
          });
        },
        child: Text(
          i.toString(),
          style: TextStyle(
            fontSize: 50,
            color: Colors.white,
          ),
        ),
      ),
    ));
  }
}
