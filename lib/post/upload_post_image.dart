import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:instagram_clone_firebase/utils/utils.dart';
import 'package:uuid/uuid.dart';

Future<String> uploadPostImage(
  File file,
  String uid,
) async {
  String downloadUrl = 'error';

  try {
    // final storage = FirebaseStorage.instance.ref();
    //
    // Reference ref = storage.child('Posts').child(
    //       FirebaseAuth.instance.currentUser!.uid +
    //           DateTime.now().millisecondsSinceEpoch.toString(),
    //     );
    //
    // UploadTask uploadTask =  ref.putFile(file);
    //
    // TaskSnapshot snap = await uploadTask;
    // downloadUrl = await snap.ref.getDownloadURL();
    //
    // return downloadUrl;

    FirebaseStorage _storage = FirebaseStorage.instance;
    String uuid = Uuid().v1();
    var ref = _storage
        .ref()
        .child('Posts')
        .child(FirebaseAuth.instance.currentUser!.uid)
        .child(uuid);
    UploadTask uploadTask = ref.putFile(file);

    TaskSnapshot snap = await uploadTask;

    String downloadUrl = await snap.ref.getDownloadURL();

    return downloadUrl;
  } catch (e) {
    Utils.showToastMessage(e.toString());
    downloadUrl = e.toString();
    return downloadUrl;
  }
}
