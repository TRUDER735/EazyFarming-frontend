import 'package:crop/pages/auth/signin.dart';
import 'package:crop/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  _signUp(String name, String email, String password) async {
    Auth auth = Auth();
    Map <String,String> body = {
      'name': name,
      'email': email,
      'password': password,
    };
    return await auth.register(body);
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
                          'Full name',
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: nameController,
                          decoration: InputDecoration(
                              prefixIcon:
                                  const Icon(size: 16.0, FontAwesomeIcons.user),
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
                        const SizedBox(height: 16),
                        const Text(
                          'Confirm Password',
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          controller: confirmPassword,
                          decoration: InputDecoration(
                              prefixIcon:
                                  const Icon(size: 16.0, FontAwesomeIcons.lock),
                              labelText: 'Confirm Password',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8))),
                          obscureText: true,
                        ),
                        const SizedBox(height: 32),
                        TextButton(
                          onPressed: () async {
                            if (passwordController.text !=
                                confirmPassword.text) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Passwords do not match')));
                              return;
                            }
                            dynamic response = await _signUp(
                              nameController.text,
                              emailController.text,
                              passwordController.text,
                            );
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
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SignInPage()));
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
                        const SizedBox(
                          height: 16,
                        ),
                      ],
                    ),
                  )
                ]))));
  }
}
