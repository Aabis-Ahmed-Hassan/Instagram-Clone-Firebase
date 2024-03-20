import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone_firebase/utils/Routes/route_names.dart';

class Utils {
  static pickImage(ImageSource source) async {
    final picker = ImagePicker();
    File pickedFile;
    var image = await picker.pickImage(source: source);

    if (image != null) {
      pickedFile = File(image.path);
      return pickedFile;
    }
  }

  static showToastMessage(String userMessage) {}

  static changeFocusNode(
      BuildContext context, FocusNode currentNode, FocusNode nextNode) {
    currentNode.unfocus();

    FocusScope.of(context).requestFocus(nextNode);
  }

  static signOutUser(BuildContext context) {
    FirebaseAuth _auth = FirebaseAuth.instance;
    _auth.signOut().then((value) {
      Navigator.pushReplacementNamed(context, RouteNames.login);
    }).onError((error, stackTrace) {
      showToastMessage(error.toString());
    });
  }
}
