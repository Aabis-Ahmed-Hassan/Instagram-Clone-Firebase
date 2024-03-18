import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class WebLayout extends StatelessWidget {
  WebLayout({super.key});

  var ref = FirebaseFirestore.instance.collection('My Colleciot');
  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   appBar: AppBar(
    //     backgroundColor: Colors.black,
    //     title: Text('Web'),
    //   ),
    // );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Web'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              ref.doc(DateTime.now().millisecondsSinceEpoch.toString()).set(
                {
                  'title': 'Instagram Clone',
                },
              );
            },
            child: Container(
              height: 50,
              width: 50,
              color: Colors.blue,
            ),
          )
        ],
      ),
    );
  }
}
