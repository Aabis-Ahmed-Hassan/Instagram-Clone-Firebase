import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone_firebase/utils/Routes/route_names.dart';
import 'package:instagram_clone_firebase/utils/Routes/routes.dart';
import 'package:instagram_clone_firebase/view_modal/user_provider.dart';
import 'package:provider/provider.dart';

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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: Colors.black,
        ),
        // home: LayoutDeterminer(
        //   WebLayout: WebLayout(),
        //   MobileLayout: MobileLayout(),
        // ),

        initialRoute: RouteNames.splash,
        onGenerateRoute: Routes.generateRoutes,
      ),
    );
  }
}
