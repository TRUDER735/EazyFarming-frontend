import 'dart:convert';

import 'package:crop/services/rest.dart';

class Messages {
  final RestService rest = RestService();

  Future<List> get() async {
    final response = await rest.get('messages/');
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to get messages');
    }
  }

  Future send(dynamic body, String token) async {
      final response = await rest.post('messages', body, token: token);
      if (response.statusCode == 200) {
        return await jsonDecode(response.body);
      } else {
        return null;
      }
    }
  }
