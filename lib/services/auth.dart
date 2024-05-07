import 'package:crop/services/rest.dart';

class Auth {
  RestService rest = RestService();

  Future register(dynamic body) async {
    final response = await rest.post('accounts/signup', body);
    if (response.statusCode == 200) {
      return response.body;
    } else {
     return null;
    }
  }

  Future signin(dynamic body) async {
    final response = await rest.post('accounts/login', body);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return null;
    }
  }

  Future logout() async {
    final response = await rest.get('logout');
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to logout user');
    }
  }
}
