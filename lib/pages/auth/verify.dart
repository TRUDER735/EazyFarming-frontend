import 'package:crop/main.dart';
import 'package:crop/user.dart';
import 'package:flutter/material.dart';

class VerifyPage extends StatefulWidget {
  const VerifyPage({super.key, required this.email});
  final String email;

  @override
  VerifyPageState createState() => VerifyPageState();
}

class VerifyPageState extends State<VerifyPage> {
  String verificationCode = '';

  void verifyEmail() {
    
    if (verificationCode == '123456') {
      UserProvider().updateUser(widget.email);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const CheckAuth()));
      // Verification successful, navigate to the next page
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      // Verification failed, show an error message
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Verification Failed'),
            content: const Text('Invalid verification code. Please try again.'),
            actions: [
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Email Verification'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Enter the verification code sent to your email:',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: 200,
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    verificationCode = value;
                  });
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Verification Code',
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: verifyEmail,
              child: const Text('Verify'),
            ),
          ],
        ),
      ),
    );
  }
}
