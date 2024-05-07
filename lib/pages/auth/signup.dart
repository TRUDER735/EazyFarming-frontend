import 'package:crop/main.dart';
import 'package:crop/pages/auth/signin.dart';
import 'package:crop/pages/crop_recommandation.dart';
import 'package:crop/services/auth.dart';
import 'package:crop/user.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  _signUp(
      String firstName, String lastName, String email, String password) async {
    Auth auth = Auth();
    Map<String, String> body = {
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'password': password,
    };
    dynamic response = await auth.register(body);
    if (!mounted) return;
    if (response != null) {
      Provider.of<SignedInUser>(context, listen: false).updateUser(email);
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const CheckAuth()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Failed to sign up make sure you have filled all the fields correctly')));
    }
    return response;
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
                          'First name',
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: firstNameController,
                          decoration: InputDecoration(
                              prefixIcon:
                                  const Icon(size: 16.0, FontAwesomeIcons.user),
                              labelText: 'Enter first name',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8))),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Last name',
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: lastNameController,
                          decoration: InputDecoration(
                              prefixIcon:
                                  const Icon(size: 16.0, FontAwesomeIcons.user),
                              labelText: 'Enter your last name',
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
                            _signUp(
                              firstNameController.text,
                              lastNameController.text,
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
