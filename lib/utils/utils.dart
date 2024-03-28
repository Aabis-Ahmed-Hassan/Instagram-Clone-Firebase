import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone_firebase/utils/Routes/route_names.dart';
import 'package:uuid/uuid.dart';

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

  static Future<void> likePost(String postId, String uid, List likes) async {
    if (likes.contains(uid)) {
      likes.remove(uid);
    } else {
      likes.add(uid);
    }
    try {
      var ref = FirebaseFirestore.instance.collection('Posts');
      await ref.doc(postId).update({
        'likes': likes,
      });
    } catch (e) {
      Utils.showToastMessage(e.toString());
    }
  }

  static Future<void> addComment(
    String uid,
    String postId,
    String profileImageUrl,
    String username,
    String comment,
  ) async {
    String commentId = Uuid().v1();
    Map<String, dynamic> data = {
      'postId': postId,
      'uid': uid,
      'profileImageUrl': profileImageUrl,
      'username': username,
      'comment': comment,
      'date': DateTime.now(),
    };

    try {
      var ref = FirebaseFirestore.instance
          .collection('Posts')
          .doc(postId)
          .collection('Comments');

      await ref.doc(commentId).set(data);
    } catch (e) {
      Utils.showToastMessage(e.toString());
    }
  }
}
