import 'package:flutter/material.dart';
import 'package:easycook_main/views/show-login-register.dart';
import 'package:easycook_main/views/login-page.dart';
import 'package:easycook_main/views/register-page.dart';
import 'package:easycook_main/views/home-page.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Roboto'),
      routes: {
        '/show-login-register': (context) => RegisterLoginPage(),
        '/login-page': (context) => LoginPage(),
        '/register-page': (context) => RegisterPage(),
        '/home-page': (context) => HomePage(),
      },
      initialRoute: '/show-login-register',
    );
  }
}
