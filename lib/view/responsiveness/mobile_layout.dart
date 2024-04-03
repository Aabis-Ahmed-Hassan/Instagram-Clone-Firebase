import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone_firebase/utils/colors.dart';

import '../../utils/constants/bottom_nav_bar_screens.dart';

class MobileLayout extends StatefulWidget {
  MobileLayout({super.key});

  @override
  State<MobileLayout> createState() => _MobileLayoutState();
}

class _MobileLayoutState extends State<MobileLayout> {
  //screens for bottom nav bar
  // List<Widget> pages = [
  //   HomeScreen(),
  //   SearchScreen(),
  //   AddPost(),
  //   RoughScreen(i: 3),
  //   ProfileScreen(
  //     uid: FirebaseAuth.instance.currentUser!.uid,
  //   ),
  // ];
  int currentPage = 0;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height * 1;
    var width = MediaQuery.of(context).size.width * 1;
    print('mobile layout screen');
    return Scaffold(
      body: IndexedStack(
        children: bottomNavBarScreens,
        index: currentPage,
      ),
      bottomNavigationBar: BottomAppBar(
        color: mobileBackgroundColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () {
                setState(() {
                  currentPage = 0;
                });
              },
              icon: Icon(
                Icons.home,
                color: currentPage == 0 ? primaryColor : tertiaryColor,
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  currentPage = 1;
                });
              },
              icon: Icon(
                Icons.search,
                color: currentPage == 1 ? primaryColor : tertiaryColor,
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  currentPage = 2;
                });
              },
              icon: Icon(
                Icons.add_box_outlined,
                color: currentPage == 2 ? primaryColor : tertiaryColor,
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  currentPage = 3;
                });
              },
              icon: Icon(
                Icons.video_call,
                color: currentPage == 3 ? primaryColor : tertiaryColor,
              ),
            ),
            FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection('Users')
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .get(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        currentPage = 4;
                      });
                    },
                    child: CircleAvatar(
                        backgroundColor: Colors.grey,
                        radius: height * 0.02,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: CachedNetworkImage(
                            imageUrl: snapshot.data['imageUrl'],
                            placeholder: (context, url) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                          ),
                        )),
                  );
                }
              },
            ),
            // IconButton(
            //   onPressed: () {
            //     setState(() {
            //       currentPage = 4;
            //     });
            //   },
            // icon: Icon(
            //   Icons.person,
            //   color: currentPage == 4 ? primaryColor : tertiaryColor,
            // ),
            // ),
          ],
        ),
      ),
    );
  }
}
//
