import 'package:flutter/material.dart';
import 'package:instagram_clone_firebase/responsiveness/layout_determiner.dart';
import 'package:instagram_clone_firebase/responsiveness/mobile_layout.dart';
import 'package:instagram_clone_firebase/responsiveness/web_layout.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
      ),
      home: LayoutDeterminer(
          WebLayout: WebLayout(), MobileLayout: MobileLayout(),),
    );
  }
}
