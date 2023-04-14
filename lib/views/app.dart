import 'package:flutter/material.dart';
import 'package:easycook_main/views/show-login-register.dart';
import 'package:easycook_main/views/splash-screen.dart';
import 'package:easycook_main/views/login-page.dart';
import 'package:easycook_main/views/register-page.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => SplashScreen(),
        '/show-login-register': (context) => RegisterLoginPage(),
        '/login-page': (context) => LoginPage(),
        '/register-page': (context) => RegisterPage(),
      },
      initialRoute: '/',
    );
  }
}
