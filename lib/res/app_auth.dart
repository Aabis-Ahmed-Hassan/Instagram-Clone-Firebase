import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone_firebase/utils/Routes/route_names.dart';
import 'package:instagram_clone_firebase/utils/add_image_on_firebase.dart';
import 'package:instagram_clone_firebase/utils/utils.dart';

class AppAuth {
  final _auth = FirebaseAuth.instance;

  final ref = FirebaseFirestore.instance.collection('Users');

  Future<String> signupUser(String email, String password, String username,
      String bio, File profilePicture, BuildContext context) async {
    String response = 'error';

    try {
      UserCredential credentials = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      String profile_picture = await AddImageOnFirebase()
          .uploadImageOnFirebase('Profile Pictures', profilePicture, false);

      await ref.doc(credentials.user!.uid).set({
        'username': username,
        'email': email,
        'password': password,
        'bio': bio,
        'followers': [],
        'following': [],
        'profile_picture': profile_picture
      });

      response = 'success';

      Navigator.pushReplacementNamed(context, RouteNames.home);
    } catch (e) {
      Utils.showToastMessage(e.toString());

      response = e.toString();
    }
    print(response);
    return response;
  }

  Future<void> loginUser(String email, String password) async {
    _auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {})
        .onError((error, stackTrace) {
      Utils.showToastMessage(error.toString());
    });
  }
}
