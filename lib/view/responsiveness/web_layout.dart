import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../utils/colors.dart';
import '../../utils/constants/bottom_nav_bar_screens.dart';

class WebLayout extends StatefulWidget {
  WebLayout({super.key});

  @override
  State<WebLayout> createState() => _WebLayoutState();
}

class _WebLayoutState extends State<WebLayout> {
  var ref = FirebaseFirestore.instance.collection('My Collection');
//screens for bottom nav bar
//   List<Widget> pages = [
//     HomeScreen(),
//     SearchScreen(),
//     AddPost(),
//     RoughScreen(i: 3),
//     ProfileScreen(
//       uid: FirebaseAuth.instance.currentUser!.uid,
//     ),
//   ];
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   appBar: AppBar(
    //     backgroundColor: Colors.black,
    //     title: Text('Web'),
    //   ),
    // );
    double height = MediaQuery.of(context).size.height * 1;
    double width = MediaQuery.of(context).size.width * 1;
    print('web layout screen');
    return Scaffold(
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   backgroundColor: mobileBackgroundColor,
      //   title: SvgPicture.asset(
      //     height: height * 0.045,
      //     'assets/images/instagram_logo.svg',
      //     color: primaryColor,
      //   ),
      //   centerTitle: false,
      //   actions: [
      //     InkWell(
      //       onTap: () {
      //         setState(() {
      //           currentPage == 0;
      //         });
      //       },
      //       child: Icon(
      //         Icons.home,
      //         color: currentPage == 0 ? primaryColor : tertiaryColor,
      //       ),
      //     ),
      //     SizedBox(
      //       width: width * 0.02,
      //     ),
      //     InkWell(
      //       onTap: () {
      //         setState(() {
      //           currentPage == 1;
      //         });
      //       },
      //       child: Icon(
      //         Icons.search,
      //         color: currentPage == 1 ? primaryColor : tertiaryColor,
      //       ),
      //     ),
      //     SizedBox(
      //       width: width * 0.02,
      //     ),
      //     InkWell(
      //       onTap: () {
      //         setState(() {
      //           currentPage == 2;
      //         });
      //       },
      //       child: Icon(
      //         Icons.add_box_outlined,
      //         color: currentPage == 2 ? primaryColor : tertiaryColor,
      //       ),
      //     ),
      //     SizedBox(
      //       width: width * 0.02,
      //     ),
      //     IconButton(
      //       onPressed: () {
      //         setState(() {
      //           currentPage == 3;
      //         });
      //       },
      //       icon: Icon(
      //         Icons.video_call,
      //         color: currentPage == 3 ? primaryColor : tertiaryColor,
      //       ),
      //     ),
      //     SizedBox(
      //       width: width * 0.02,
      //     ),
      //     FutureBuilder(
      //       future: FirebaseFirestore.instance
      //           .collection('Users')
      //           .doc(FirebaseAuth.instance.currentUser!.uid)
      //           .get(),
      //       builder: (context, AsyncSnapshot snapshot) {
      //         if (snapshot.connectionState == ConnectionState.waiting) {
      //           return Center(
      //             child: CircularProgressIndicator(),
      //           );
      //         } else {
      //           return InkWell(
      //             onTap: () {
      //               setState(() {
      //                 currentPage = 4;
      //               });
      //             },
      //             child: CircleAvatar(
      //                 backgroundColor: Colors.grey,
      //                 radius: height * 0.02,
      //                 child: ClipRRect(
      //                   borderRadius: BorderRadius.circular(100),
      //                   child: CachedNetworkImage(
      //                     imageUrl: snapshot.data['imageUrl'],
      //                     placeholder: (context, url) {
      //                       return Center(
      //                         child: CircularProgressIndicator(),
      //                       );
      //                     },
      //                   ),
      //                 )),
      //           );
      //         }
      //       },
      //     ),
      //     SizedBox(
      //       width: width * 0.015,
      //     ),
      //   ],
      // ),
      body: IndexedStack(
        children: bottomNavBarScreens,
        index: currentPage,
      ),
      bottomNavigationBar: BottomAppBar(
          color: mobileBackgroundColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    currentPage = 0;
                  });
                },
                child: Icon(
                  Icons.home,
                  color: currentPage == 0 ? primaryColor : tertiaryColor,
                ),
              ),
              SizedBox(
                width: width * 0.02,
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    currentPage = 1;
                  });
                },
                child: Icon(
                  Icons.search,
                  color: currentPage == 1 ? primaryColor : tertiaryColor,
                ),
              ),
              SizedBox(
                width: width * 0.02,
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    currentPage = 2;
                  });
                },
                child: Icon(
                  Icons.add_box_outlined,
                  color: currentPage == 2 ? primaryColor : tertiaryColor,
                ),
              ),
              SizedBox(
                width: width * 0.02,
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
              SizedBox(
                width: width * 0.02,
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
              SizedBox(
                width: width * 0.015,
              ),
            ],
          )),
    );
  }
}
