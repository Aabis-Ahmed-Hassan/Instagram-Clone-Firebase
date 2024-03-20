import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_clone_firebase/modals/user_modal.dart';

class UserDetails {
  static Future<UserModal> getUserDetails() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    return UserModal.userDetails(snap);
  }
}
