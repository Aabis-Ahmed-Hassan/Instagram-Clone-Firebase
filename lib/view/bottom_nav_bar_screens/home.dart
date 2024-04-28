import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instagram_clone_firebase/utils/colors.dart';
import 'package:instagram_clone_firebase/utils/constants/responsive_dimensions.dart';

import '../../components/my_post.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var ref = FirebaseFirestore.instance
      .collection('Posts')
      .orderBy('datePublished', descending: true)
      .snapshots();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height * 1;
    double width = MediaQuery.of(context).size.width * 1;

    print('home screen');

    return Scaffold(
      backgroundColor:
          width > WebDimensions ? webBackgroundColor : mobileBackgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: mobileBackgroundColor,
        title: SvgPicture.asset(
          height: height * 0.045,
          'assets/images/instagram_logo.svg',
          color: primaryColor,
        ),
        centerTitle: false,
        actions: [
          Icon(
            FontAwesomeIcons.heart,
            color: tertiaryColor,
          ),
          SizedBox(
            width: width * 0.03,
          ),
          Icon(
            FontAwesomeIcons.facebookMessenger,
            color: tertiaryColor,
          ),
          SizedBox(
            width: width * 0.02,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: ref,
              builder: (context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snap) {
                if (snap.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return ListView.builder(
                    itemCount: snap.data!.docs.length,
                    itemBuilder: (context, index) {
                      return MyPost(
                        //it will show the latest post at top
                        snapshot: snap.data!.docs[index].data(),
                      );
                    },
                  );
                }
              },
            ),
          ),
          Expanded(
            child: Container(
              height: 50,
              width: 250,
              color: Colors.blue,
            ),
          ),
          Expanded(
            child: FutureBuilder(
                future: FirebaseFirestore.instance.collection('Posts').get(),
                builder: (context, AsyncSnapshot snapshot) {
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      print(snapshot.data!.docs[index]['postImageUrl'].toString());

                      return MyPost(snapshot: snapshot.data!.docs[index]);
                    },
                  );
                }),
          )
        ],
      ),
    );
  }
}
