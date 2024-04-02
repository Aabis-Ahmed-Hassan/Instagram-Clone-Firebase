import 'package:flutter/material.dart';
import 'package:instagram_clone_firebase/view/auth/login_view.dart';
import 'package:instagram_clone_firebase/view/auth/signup_view.dart';
import 'package:instagram_clone_firebase/view/splash_view.dart';

import '../../view/responsiveness/layout_determiner.dart';
import '../../view/responsiveness/mobile_layout.dart';
import '../../view/responsiveness/web_layout.dart';
import 'route_names.dart';

class Routes {
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.login:
        return MaterialPageRoute(builder: (context) => LoginView());

      case RouteNames.signup:
        return MaterialPageRoute(builder: (context) => SignUpView());

      case RouteNames.splash:
        return MaterialPageRoute(builder: (context) => SplashView());

      case RouteNames.mobile:
        return MaterialPageRoute(builder: (context) => MobileLayout());

      case RouteNames.web:
        return MaterialPageRoute(builder: (context) => WebLayout());

      case RouteNames.layout_determiner:
        return MaterialPageRoute(
            builder: (context) => LayoutDeterminer(
                WebLayout: WebLayout(), MobileLayout: MobileLayout()));

      default:
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            body: Center(
              child: Text('No Routes are Defined'),
            ),
          ),
        );
    }
  }
}
