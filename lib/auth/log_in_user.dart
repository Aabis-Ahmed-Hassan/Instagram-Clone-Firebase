import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone_firebase/utils/Routes/route_names.dart';
import 'package:instagram_clone_firebase/utils/utils.dart';

class LogInUser {
  final _auth = FirebaseAuth.instance;

  final ref = FirebaseFirestore.instance.collection('Users');

  Future<void> logInUser(
      String email, String password, BuildContext context) async {
    try {
      _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        Navigator.pushReplacementNamed(context, RouteNames.layout_determiner);
      }).onError((error, stackTrace) {
        Utils.showToastMessage(error.toString());
      });
    } catch (e) {
      Utils.showToastMessage(e.toString());
    }
  }
}
