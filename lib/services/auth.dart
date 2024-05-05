import 'package:crop/services/rest.dart';

class Auth {
  RestService rest = RestService();

  Future register(dynamic body) async {
    final response = await rest.post('farmers', body);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to register user');
    }
  }

  Future signin(dynamic body) async {
    final response = await rest.post('login', body);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to login user');
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
