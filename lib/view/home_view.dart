import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone_firebase/utils/utils.dart';

class HomeView extends StatefulWidget {
  HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  FirebaseAuth _auth = FirebaseAuth.instance;

  var _ref = FirebaseFirestore.instance.collection('Users').snapshots();

  void signOut() {
    Utils.signOutUser(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HomeScreen'),
      ),
      body: Center(
        child: Column(
          children: [
            InkWell(
              onTap: () {
                var a = _auth.currentUser!.uid;
                print(a);
              },
              child: Container(
                height: 50,
                width: 50,
                color: Colors.blue,
              ),
            ),
            InkWell(
              onTap: signOut,
              child: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
