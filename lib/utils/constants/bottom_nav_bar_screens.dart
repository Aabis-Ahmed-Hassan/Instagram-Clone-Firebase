import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone_firebase/view/bottom_nav_bar_screens/reels_screen.dart';

import '../../view/bottom_nav_bar_screens/add_post.dart';
import '../../view/bottom_nav_bar_screens/home.dart';
import '../../view/bottom_nav_bar_screens/profile_screen.dart';
import '../../view/bottom_nav_bar_screens/search_screen.dart';

List<Widget> bottomNavBarScreens = [
  HomeScreen(),
  SearchScreen(),
  AddPost(),
  ReelsScreen(),
  ProfileScreen(
    uid: FirebaseAuth.instance.currentUser!.uid,
  ),
];
