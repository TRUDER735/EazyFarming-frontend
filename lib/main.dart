import 'package:crop/pages/auth/signin.dart';
import 'package:crop/pages/home.dart';
import 'package:crop/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => SignedInUser(), child: const MyApp()));
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

  _getUser(BuildContext context) async {
    bool signedIn =
        Provider.of<SignedInUser>(context,listen: false).email != "" ? true : false;
    return signedIn;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getUser(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          final bool isSignedIn = snapshot.data as bool;
          return isSignedIn ? const Home() : const SignInPage();
        }
      },
    );
  }
}
