import 'package:flutter/foundation.dart';

class UserProvider extends ChangeNotifier {
  String _email = "";
  int _id = 0;
  String _name = "";
  String _token = "";

  // Getters for the private variables
  String get email => _email;
  int get id => _id;
  String get name => _name;
  String get token => _token;

  Future<void> updateUser(dynamic user) async {
    _email = user["email"];
    _id = user["user_id"];
    _name = user["first_name"];
    _token = user["token"];
    notifyListeners();
  }

  Future<void> logOut() async {
    _email = "";
    _id = 0;
    _name = "";
    _token = "";
    notifyListeners();
  }
}
