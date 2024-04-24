import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

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
                          'Full name',
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          decoration: InputDecoration(
                              prefixIcon: const Icon(
                                  size: 16.0, FontAwesomeIcons.user),
                              labelText: 'Enter first and last name',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8))),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Email',
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          decoration: InputDecoration(
                              prefixIcon: const Icon(size:16.0,FontAwesomeIcons.envelope),
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
                          decoration: InputDecoration(
                              prefixIcon: const Icon(size:16.0,FontAwesomeIcons.lock),
                              labelText: 'Password',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8))),
                          obscureText: true,
                        ),
                        const SizedBox(height: 32),
                        TextButton(
                          onPressed: () {
                            // Add sign-in logic here
                          },
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.grey[800],
                            minimumSize: const Size(double.infinity, 60),
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8))),
                          ),
                          child: const Text('Sign up'),
                        ),
                        const SizedBox(height: 16),
                        TextButton(
                          onPressed: () {
                            // Add sign-in logic here
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
                          child: const Text("Already have an account? Sign In"),
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                        TextButton(
                          onPressed: () {
                            // Add sign-in logic here
                          },
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.black,
                            backgroundColor:
                                const Color.fromARGB(0, 221, 221, 221),
                            minimumSize: const Size(double.infinity, 60),
                            shape: const RoundedRectangleBorder(
                                side: BorderSide(),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8))),
                          ),
                          child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                FaIcon(
                                  size: 15.0,
                                  FontAwesomeIcons.google,
                                ),
                                SizedBox(width: 16.0,),
                                Text("Sign in with Google"),
                              ],
                            ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                      ],
                    ),
                  )
                ]))));
  }
}
