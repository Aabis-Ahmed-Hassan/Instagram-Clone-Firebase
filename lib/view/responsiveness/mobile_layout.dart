import 'package:flutter/material.dart';
import 'package:instagram_clone_firebase/rough_screen.dart';
import 'package:instagram_clone_firebase/utils/colors.dart';

import '../add_post.dart';

class MobileLayout extends StatefulWidget {
  MobileLayout({super.key});

  @override
  State<MobileLayout> createState() => _MobileLayoutState();
}

class _MobileLayoutState extends State<MobileLayout> {
  List<Widget> pages = [
    RoughScreen(i: 0),
    RoughScreen(i: 1),
    AddPost(),
    RoughScreen(i: 3),
    RoughScreen(i: 4),
  ];
  int currentPage = 2;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height * 1;
    var width = MediaQuery.of(context).size.width * 1;
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.green,
      // ),
      body: IndexedStack(
        children: pages,
        index: currentPage,
      ),

      // bottomNavigationBar: BottomNavigationBar(
      //   currentIndex: currentPage,
      //   onTap: (int page) {
      //     setState(() {
      //       currentPage = page;
      //     });
      //   },
      //   items: [
      //     BottomNavigationBarItem(
      //       icon: Icon(
      //         Icons.add,
      //         color: primaryColor,
      //       ),
      //       label: '',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(
      //         Icons.add,
      //         color: primaryColor,
      //       ),
      //       label: '',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(
      //         Icons.add,
      //         color: primaryColor,
      //       ),
      //       label: '',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(
      //         Icons.add,
      //         color: primaryColor,
      //       ),
      //       label: '',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(
      //         Icons.add,
      //         color: primaryColor,
      //       ),
      //       label: '',
      //     ),
      //   ],
      // ),

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
                color: currentPage == 0 ? primaryColor : secondaryColor,
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
                color: currentPage == 1 ? primaryColor : secondaryColor,
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
                color: currentPage == 2 ? primaryColor : secondaryColor,
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
                color: currentPage == 3 ? primaryColor : secondaryColor,
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  currentPage = 4;
                });
              },
              icon: Icon(
                Icons.person,
                color: currentPage == 4 ? primaryColor : secondaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
//
