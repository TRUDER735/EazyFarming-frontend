import 'dart:convert';

import 'package:crop/services/auth.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignedInUser extends ChangeNotifier {
  String email = "";
  int id = 0;

  void updateUser(String newEmail) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    email = newEmail;
    if (newEmail != "") {
      await prefs.setString('signedInUser', email);
      await setId(newEmail);
      notifyListeners();
    }
  }

  Future<void> setId(String newEmail) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Auth auth = Auth();
    dynamic user = jsonDecode(await auth.getUser(email));
    id = user['id'];
    await prefs.setInt('id', id);
    notifyListeners();
  }

  Future<String> getSignedInUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String retrievedEmail = prefs.getString('signedInUser') ?? "";
    updateUser(retrievedEmail);
    return retrievedEmail;
  }

  void logOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('signedInUser');
    await prefs.remove('id');
    email = "";
    id = 0;
    notifyListeners();
  }
}
