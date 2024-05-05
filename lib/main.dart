import 'package:crop/pages/auth/signin.dart';
import 'package:crop/pages/auth/signup.dart';
import 'package:crop/pages/home.dart';
import 'package:crop/pages/profile/new.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      home: CheckAuth(),
      // routes: {
      //   '/': (context) => SignInPage()
      // },
    );
  }
}

class CheckAuth extends StatelessWidget {
  const CheckAuth({Key? key}) : super(key: key);

  _getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isSignedIn') ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getUser(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          final bool isSignedIn = snapshot.data as bool;
          return isSignedIn ? const Home() : const SignInPage() ;
        }
      },
    );
  }
}
