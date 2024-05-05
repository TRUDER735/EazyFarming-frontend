import 'package:crop/services/rest.dart';

class Messages{
  final RestService rest = RestService();

  Future getMessages() async {
    final response = await rest.get('messages');
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to get messages');
    }
  }
  
}