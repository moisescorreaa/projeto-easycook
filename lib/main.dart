import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'views/app.dart';

const firebaseConfig = FirebaseOptions(
    apiKey: "AIzaSyAePqUL7kbW3usr3p0mYB_9fWMvufjx1dM",
    authDomain: "easy-cook-2117a.firebaseapp.com",
    projectId: "easy-cook-2117a",
    storageBucket: "easy-cook-2117a.appspot.com",
    messagingSenderId: "722219545734",
    appId: "1:722219545734:web:ffc3f657fb23baa352cd07",
    measurementId: "G-P3VHW9LKFK");

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: firebaseConfig);
  runApp(App());
}
