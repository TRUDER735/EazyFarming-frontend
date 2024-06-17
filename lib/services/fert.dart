import 'dart:convert';

import 'package:crop/services/rest.dart';

class Fert {
  final RestService rest = RestService();

//   then for fert
// to get fertilizer recommendation you need

// so first you will need to add Region_Name,Soil_color,Crop
// @api/add_input_data
// NB crop unoisa Crop iri mu field

// then after updating data you api/fert_rec
// to get recommendation

  Future fertRec(dynamic data) async {
    // final response = await rest.post('add_input_data', data);
    // if (response.statusCode == 200) {
    final response = await rest.get('fert_rec/');
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }else{
      throw Exception('Failed to get recommendation');
    }
    // } else {
    //   throw Exception('Failed to get recommendation');
    // }
  }
}
