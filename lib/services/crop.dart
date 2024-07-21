import 'dart:convert';

import 'package:crop/services/rest.dart';

class Crop {
  final RestService rest = RestService();

  Future recommendation(int rainfall) async {
    dynamic body = {"Rainfall": rainfall.toString()};
    final res = await rest.post(
      'add_rainfall',
      body,
    );
    if (res.statusCode == 200) {
      final response = await rest.get('recommendation/');
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to get recommendation');
      }
      } else {
        throw Exception('Failed to get recommendation');
      }
    }
  }

