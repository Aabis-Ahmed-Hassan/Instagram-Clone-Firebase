import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone_firebase/responsiveness/layout_determiner.dart';
import 'package:instagram_clone_firebase/responsiveness/mobile_layout.dart';
import 'package:instagram_clone_firebase/responsiveness/web_layout.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
        WebLayout: WebLayout(),
        MobileLayout: MobileLayout(),
      ),
    );
  }
}
