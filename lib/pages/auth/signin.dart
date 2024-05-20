import 'package:crop/pages/auth/signup.dart';
import 'package:crop/pages/home.dart';
import 'package:crop/services/auth.dart';
import 'package:crop/user.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  _signIn(String email, String password) async {
    Auth auth = Auth();
    final body = {"email": email, "password": password};
    final user = await auth.signin(body);
    if (!mounted) return;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Incorrect username or password')));
    } else {
      Provider.of<UserProvider>(context,listen: false).updateUser(email);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Home()));
    }
  }

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String variable = "";

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Center(
          child: Text('Sign In'),
        )),
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(children: [
              const Text('Sign in to your account'),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Email',
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                          prefixIcon: const Icon(
                              size: 16.0, FontAwesomeIcons.envelope),
                          labelText: 'Enter email address',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8))),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Password',
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: passwordController,
                      decoration: InputDecoration(
                          prefixIcon:
                              const Icon(size: 16.0, FontAwesomeIcons.lock),
                          labelText: 'Password',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8))),
                      obscureText: true,
                    ),
                    const SizedBox(height: 8),
                    const Text('Forgot password?'),
                    const SizedBox(height: 32),
                    TextButton(
                      onPressed: () {
                        _signIn(
                            emailController.text.trim(), passwordController.text);
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.grey[800],
                        minimumSize: const Size(double.infinity, 60),
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(8))),
                      ),
                      child: const Text('Sign In'),
                    ),
                    const SizedBox(height: 16),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignUpPage()));
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.black,
                        backgroundColor:
                            const Color.fromARGB(255, 221, 221, 221),
                        minimumSize: const Size(double.infinity, 60),
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(8))),
                      ),
                      child: const Text("Don't have an account? Sign Up"),
                    ),
                    Text(variable)
                  ],
                ),
              )
            ])));
  }
}
