import 'package:crop/pages/auth/signin.dart';
import 'package:crop/pages/auth/signup.dart';
import 'package:crop/pages/home.dart';
import 'package:crop/pages/profile/new.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: Home(),
      // routes: {
      //   '/': (context) => SignInPage()
      // },
    );
  }
}

