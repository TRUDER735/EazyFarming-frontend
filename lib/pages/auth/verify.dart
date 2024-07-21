import 'package:crop/pages/home.dart';
import 'package:crop/services/auth.dart';
import 'package:crop/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VerifyPage extends StatefulWidget {
  const VerifyPage({super.key, required this.user});
  final dynamic user;

  @override
  VerifyPageState createState() => VerifyPageState();
}

class VerifyPageState extends State<VerifyPage> {
  final TextEditingController codeController = TextEditingController();
  final Auth auth = Auth();
  bool isLoading = false;
  static const String correctCode = '123456'; // Replace with your logic

  Future<void> verifyEmail(String code) async {
    setState(() {
      isLoading = true;
    });
    try {
      if (code == correctCode) {
        final response = await auth.activate({
          "code": correctCode,
          "email": widget.user['email']
        });
        if (response.statusCode >= 200 && response.statusCode < 300) {
          final body = {
            "email": widget.user['email'],
            "password": widget.user['password']
          };
          final user = await auth.signin(body);
          if (mounted) {
            Provider.of<UserProvider>(context, listen: false).updateUser(user);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const Home()),
            );
          }
        } else {
          _showErrorDialog('Verification failed, please try again.');
        }
      } else {
        _showErrorDialog('Invalid verification code. Please try again.');
      }
    } catch (e) {
      _showErrorDialog('An error occurred. Please try again later.');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
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
                controller: codeController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Verification Code',
                ),
              ),
            ),
            const SizedBox(height: 16),
            isLoading
                ? const CircularProgressIndicator()
                : TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: const Color.fromARGB(255, 221, 221, 221),
                      minimumSize: const Size(120.0, 60),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                    ),
                    onPressed: () async {
                      await verifyEmail(codeController.text);
                    },
                    child: const Text('Verify'),
                  ),
          ],
        ),
      ),
    );
  }
}
