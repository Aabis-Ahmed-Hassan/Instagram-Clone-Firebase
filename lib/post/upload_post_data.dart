import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone_firebase/modals/post_modal.dart';
import 'package:instagram_clone_firebase/post/upload_post_image.dart';
import 'package:instagram_clone_firebase/utils/utils.dart';
import 'package:uuid/uuid.dart';

Future<void> uploadPostData(
  File file,
  String uid,
  String description,
  String username,
  String profileImage,
) async {
  try {
    var ref = FirebaseFirestore.instance.collection('Posts');

    String postImageUrl = await uploadPostImage(file, uid);
    String postId = Uuid().v1();
    PostModal post = PostModal(
      description: description,
      uid: uid,
      username: username,
      postId: postId,
      datePublished: DateTime.now(),
      profileImage: profileImage,
      likes: [],
      postImageUrl: postImageUrl,
    );

    ref.doc(postId).set(post.toJson());
  } catch (e) {
    Utils.showToastMessage(e.toString());
  }
}
