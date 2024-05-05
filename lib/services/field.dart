import 'package:crop/services/rest.dart';

class Field {
  final RestService rest = RestService();

  
  Future get(String farmerID) async {
    final response = await rest.get('farms');
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to get messages');
    }
  }

  // Future delete(String farmerID, String fieldID){
  //   final response = await rest.delete();
  //   return response;
  // }
}
