import 'package:crop/services/auth.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider extends ChangeNotifier {
  String email = "";
  int id = 0;
  String name = "";

  UserProvider() {
    getSignedInUser();
  }

  Future<void> updateUser(String newEmail) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (newEmail != "") {
      await prefs.setString('signedInUser', newEmail);
      await setId(newEmail);
      notifyListeners();
    }
    email = newEmail;
  }

  Future<void> setId(String newEmail) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Auth auth = Auth();
    dynamic user = await auth.getUser(newEmail);
    if (user != null) {
      await prefs.setInt('id', id);
      id = user['id'];
      name = user['first_name'];
      notifyListeners();
    }
  }

  Future<String> getSignedInUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String retrievedEmail = prefs.getString('signedInUser') ?? "";
    updateUser(retrievedEmail);
    return retrievedEmail;
  }

  Future<void> logOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('signedInUser');
    await prefs.remove('id');
    email = "";
    id = 0;
    notifyListeners();
  }
}
