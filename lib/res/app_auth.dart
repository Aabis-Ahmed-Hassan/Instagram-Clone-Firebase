import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AppAuth {
  final _auth = FirebaseAuth.instance;

  final ref = FirebaseFirestore.instance.collection('Users');

  Future<String> signupUser(
    String email,
    String password,
    String username,
    String bio,
  ) async {
    String response = 'error';

    try {
      UserCredential credentials = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await ref.doc(credentials.user!.uid).set({
        'username': username,
        'email': email,
        'password': password,
        'bio': bio,
        'followers': [],
        'following': [],
      });

      response = 'success';
    } catch (e) {
      response = e.toString();
    }
    print(response);
    return response;
  }
}
