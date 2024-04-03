// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/foundation.dart';
//
// class PostLikeProvider with ChangeNotifier {
//   bool _isLiked = false;
//
//   final String postId;
//
//   PostLikeProvider({required this.postId});
//
//   void fetchLikesFromFirestore() async {
//     var fbData =
//         await FirebaseFirestore.instance.collection('Posts').doc('afd').get();
//     List likes = fbData['likes'];
//
//     if (likes.contains(FirebaseAuth.instance.currentUser!.uid)) {
//       _isLiked = true;
//     } else {
//       _isLiked = false;
//     }
//   }
//
//   bool get isLiked => _isLiked;
//
//   void setLiked() {
//     _isLiked = !_isLiked;
//
//     notifyListeners();
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class PostLikeProvider with ChangeNotifier {
  bool _isLiked = false;
  final String postId;
  int totalLikes = 0;

  // Constructor
  PostLikeProvider({required this.postId}) {
    // Fetch like/dislike details when the provider is created
    fetchLikesFromFirestore();
  }

  // Method to fetch likes/dislikes from Firestore
  void fetchLikesFromFirestore() async {
    try {
      DocumentSnapshot fbData = await FirebaseFirestore.instance
          .collection('Posts')
          .doc(postId)
          .get();
      List likes = fbData['likes'];
      totalLikes = likes.length;

      // Check if current user has liked the post
      if (likes.contains(FirebaseAuth.instance.currentUser!.uid)) {
        _isLiked = true;
      } else {
        _isLiked = false;
      }

      // Notify listeners after fetching data
      notifyListeners();
    } catch (error) {
      // Handle any potential errors here
      print("Error fetching likes: $error");
    }
  }

  // Getter for isLiked
  bool get isLiked => _isLiked;

  // Method to toggle like/dislike status
  void toggleLikeStatus() {
    if (isLiked) {
      incrementLike(-1);
    } else {
      incrementLike(1);
    }
    _isLiked = !_isLiked;
    // No need to fetch data again, just notify listeners
    notifyListeners();
  }

  void incrementLike(int increment) {
    totalLikes += increment;
    notifyListeners();
  }
}
