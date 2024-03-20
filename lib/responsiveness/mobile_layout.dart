import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone_firebase/utils/Routes/route_names.dart';

class MobileLayout extends StatefulWidget {
  MobileLayout({super.key});

  @override
  State<MobileLayout> createState() => _MobileLayoutState();
}

class _MobileLayoutState extends State<MobileLayout> {
  var ref = FirebaseFirestore.instance.collection('Check');

  String username = 'asd';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  void fetchData() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    username = (snap.get as Map)['username'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange,
          title: Text('Mobile'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, RouteNames.mobile);
                },
                child: Container(
                  height: 50,
                  width: 250,
                  color: Colors.blue,
                  child: Text('Refresh'),
                ),
              ),
              Text(
                username,
                style: TextStyle(fontSize: 50),
              ),
              InkWell(
                onTap: () {
                  FirebaseAuth.instance.signOut().then((value) {
                    Navigator.pushNamed(context, RouteNames.login);
                  });
                },
                child: Container(
                  height: 50,
                  width: 250,
                  color: Colors.red,
                  child: Text('Logout'),
                ),
              ),
            ],
          ),
        ));
  }
}
