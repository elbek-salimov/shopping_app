import 'package:flutter/material.dart';

import 'auth/login_page.dart';
import 'home/home_page.dart';
import 'splash/splash_page.dart';

class AppRoutes {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.splash:
        return navigate(const SplashPage());
      case RouteNames.login:
        return navigate(LoginPage());
      case RouteNames.home:
        Map<String, dynamic> data = settings.arguments as Map<String, dynamic>;
        return navigate(HomePage(token: data['token'] as String));


      default:
        return navigate(
          const Scaffold(
            body: Center(
              child: Text('This page does not exist'),
            ),
          ),
        );
    }
  }

  static navigate(Widget widget) =>
      MaterialPageRoute(builder: (context) => widget);
}

class RouteNames {
  static const String splash = '/';
  static const String login = '/login_route';
  static const String home = '/home_route';
}
