import 'package:cloud_firestore/cloud_firestore.dart';

class UserModal {
  final String? username;

  final String? email;
  final String? password;
  final String? uid;

  final String? bio;
  final String? imageUrl;
  final List? followers;
  final List? following;

  UserModal({
    required this.username,
    required this.email,
    required this.password,
    required this.uid,
    required this.bio,
    required this.imageUrl,
    required this.followers,
    required this.following,
  });

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      'password': password,
      'uid': uid,
      'bio': bio,
      'imageUrl': imageUrl,
      'followers': followers,
      'following': following,
    };
  }

  static UserModal userDetails(DocumentSnapshot snapshot) {
    UserModal _myUser;

    Map snap = snapshot.data() as Map;

    return UserModal(
      username: snap['username'],
      email: snap['email'],
      password: snap['password'],
      uid: snap['uid'],
      bio: snap['bio'],
      imageUrl: snap['imageUrl'],
      followers: snap['followers'],
      following: snap['following'],
    );
  }
}
