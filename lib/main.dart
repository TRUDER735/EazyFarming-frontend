import 'package:crop/pages/auth/signin.dart';
import 'package:crop/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UserProvider>(
      create: (context) => UserProvider(),
      child: const MaterialApp(
        title: 'Flutter Demo',
        home:  SignInPage(),
      ),
    );
  }
}
