import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone_firebase/utils/Routes/route_names.dart';

class UserStatus {
  FirebaseAuth _auth = FirebaseAuth.instance;
  void isLogin(BuildContext context) {
    var user = _auth.currentUser;

    if (user != null) {
      Timer(Duration(seconds: 3), () {
        Navigator.pushReplacementNamed(context, RouteNames.layout_determiner);
      });
    } else {
      Timer(Duration(seconds: 3), () {
        Navigator.pushReplacementNamed(context, RouteNames.login);
      });
    }
  }
}
