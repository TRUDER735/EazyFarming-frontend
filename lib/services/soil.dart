import 'dart:convert';

import 'package:crop/services/rest.dart';

class Soil {
  final RestService rest = RestService();

  Future get() async {
    final response = await rest.get('current_condition/');
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to get messages');
    }
  }
}
