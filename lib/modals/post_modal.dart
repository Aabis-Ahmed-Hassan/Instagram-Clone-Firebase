import 'package:cloud_firestore/cloud_firestore.dart';

class PostModal {
  final String? description;
  final String? uid;
  final String? username;
  final String? postId;
  final DateTime datePublished;

  final String? profileImage;

  final likes;
  final String? postImageUrl;

  PostModal({
    required this.description,
    required this.uid,
    required this.username,
    required this.postId,
    required this.datePublished,
    required this.profileImage,
    required this.likes,
    required this.postImageUrl,
  });

  toJson() {
    Map<String, dynamic> map = {
      'description': description,
      'uid': uid,
      'username': username,
      'postId': postId,
      'datePublished': datePublished,
      'profileImage': profileImage,
      'likes': likes,
      'postImageUrl': postImageUrl,
    };

    return map;
  }

  static PostModal postDetails(DocumentSnapshot snapshot) {
    Map map = snapshot.data() as Map;

    return PostModal(
        description: snapshot['description'],
        uid: snapshot['uid'],
        username: snapshot['username'],
        postId: snapshot['postId'],
        datePublished: snapshot['datePublished'],
        profileImage: snapshot['profileImage'],
        likes: snapshot['likes'],
        postImageUrl: snapshot['postImageUrl']);
  }
}
