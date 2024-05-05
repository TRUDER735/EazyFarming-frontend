import 'package:crop/pages/auth/signup.dart';
import 'package:crop/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  _signIn(String username, String password) async {
    Auth auth = Auth();
    final body = {"username": username, "password": password};
    final user = auth.signin(body);
    return user;
  }

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  String variable = "";

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    usernameController.dispose();
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
        body: Center(
            child: Padding(
                padding: const EdgeInsets.all(16),
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
                          controller: usernameController,
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
                          onPressed: () async {
                            final response = await _signIn(
                                usernameController.text,
                                passwordController.text);
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
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> const SignUpPage()));
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
                ]))));
  }
}
