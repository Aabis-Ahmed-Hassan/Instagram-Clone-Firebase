import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone_firebase/modals/user_modal.dart';
import 'package:instagram_clone_firebase/utils/Routes/route_names.dart';
import 'package:instagram_clone_firebase/utils/add_image_on_firebase.dart';
import 'package:instagram_clone_firebase/utils/utils.dart';

class SignUpUser {
  final _auth = FirebaseAuth.instance;

  final ref = FirebaseFirestore.instance.collection('Users');

  Future<String> signUpUser(String email, String password, String username,
      String bio, File profilePicture, BuildContext context) async {
    String response = 'error';

    try {
      UserCredential credentials = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      String profile_picture = await AddImageOnFirebase()
          .uploadImageOnFirebase('Profile Pictures', profilePicture, false);

      UserModal user = UserModal(
          username: username,
          email: email,
          password: password,
          uid: credentials.user!.uid,
          bio: bio,
          imageUrl: profile_picture,
          followers: [],
          following: []);

      await ref.doc(credentials.user!.uid).set(user.toJson());

      response = 'success';

      Navigator.pushReplacementNamed(context, RouteNames.layout_determiner);
    } catch (e) {
      Utils.showToastMessage(e.toString());

      response = e.toString();
    }
    print(response);
    return response;
  }
}
