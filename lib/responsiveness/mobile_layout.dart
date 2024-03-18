import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MobileLayout extends StatelessWidget {
  MobileLayout({super.key});

  var ref = FirebaseFirestore.instance.collection('Check');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange,
          title: Text('Mobile'),
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
        ));
  }
}
