import 'dart:convert';

import 'package:crop/services/rest.dart';

class Field {
  final RestService rest = RestService();

  Future get(String farmerID) async {
    final response = await rest.get('farms/');
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to get messages');
    }
  }

  Future delete(String fieldID) async {
    final response = await rest.delete('farms/', fieldID);
    return response;
  }

  Future create(dynamic body) async {
    final response = await rest.post('farms', body);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return null;
    }
  }
}
