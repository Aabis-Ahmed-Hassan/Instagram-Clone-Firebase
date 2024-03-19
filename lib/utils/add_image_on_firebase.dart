import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AddImageOnFirebase {
  final _storage = FirebaseStorage.instance;
  final _auth = FirebaseAuth.instance;
  Future<String> uploadImageOnFirebase(
      String childName, File file, bool isPost) async {
    final ref = _storage.ref().child(childName).child(_auth.currentUser!.uid);

    UploadTask uploadTask = ref.putFile(file);
    TaskSnapshot snap = await uploadTask;

    String downloadUrl = await snap.ref.getDownloadURL();

    return downloadUrl;
  }
}
