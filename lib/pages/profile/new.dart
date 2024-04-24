import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:image_picker/image_picker.dart';

class NewProfilePage extends StatefulWidget {
  const NewProfilePage({super.key});

  @override
  State<NewProfilePage> createState() => _NewProfilePageState();
}

class _NewProfilePageState extends State<NewProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Center(
          child: Text('Complete Profile'),
        )),
        body: Center(
            child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(children: [
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(20),
                      backgroundColor: const Color.fromARGB(255, 221, 221, 221),
                      minimumSize: const Size(120, 120),
                    ),
                    child: const Icon(FontAwesomeIcons.camera,color: Colors.black),
                  ),
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
                          decoration: InputDecoration(
                              prefixIcon: const Icon(
                                  size: 16.0, FontAwesomeIcons.envelope),
                              labelText: 'Enter email address',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8))),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'DOB',
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          decoration: InputDecoration(
                              prefixIcon:
                                  const Icon(size: 16.0, FontAwesomeIcons.calendar),
                              labelText: 'Select your date of birth',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8))),
                        ),
                         const SizedBox(height: 16),
                        const Text(
                          'Location of Agro-business',
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          decoration: InputDecoration(
                              prefixIcon:
                                  const Icon(size: 16.0, FontAwesomeIcons.locationPin),
                              labelText: 'Location',
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
                      ],
                    ),
                  )
                ]))));
  }
}
