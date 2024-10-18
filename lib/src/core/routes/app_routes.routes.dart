import 'package:flutter/material.dart';
import 'package:gchat/src/modules/loginAndRegister/views/loginAndRegister.view.dart';
import 'package:gchat/src/modules/splash/views/splash.view.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> routes = {
    SplashView.routeName: (context) => const SplashView(),
    LoginAndRegister.routeName: (context) => const LoginAndRegister(),
  };
}
