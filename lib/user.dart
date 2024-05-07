import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignedInUser extends ChangeNotifier {
  String email = "";

  void updateUser(String newEmail) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    email = newEmail;
    await prefs.setString('signedInUser', email);
    notifyListeners();
  }

  void getSignedInUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = prefs.getString('signedInUser') ?? "";
    updateUser(email);
  }

  void logOut() async {
    email = "";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('signedInUser');
    notifyListeners();
  }
}
