import 'package:http/http.dart' as http;

class RestService {
  final String baseUrl = "https://eazyfarmapi.onrender.com/api/";
  // final String baseUrl = "http://localhost:8000/api/";

  Future<http.Response> get(String path) async {
    final url = Uri.parse('$baseUrl$path');
    final response = await http.get(url);
    return response;
  }

  Future<http.Response> post(String path, dynamic body, {String? token}) async {
    final url = Uri.parse('$baseUrl$path/');
    if (token != null) {
      final response = await http.post(url, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      });
      return response;
    } else {
      final response = await http.post(url, body: body);
      return response;
    }
  }

  Future<http.Response> delete(String path, String id) async {
    final url = Uri.parse('$baseUrl$path/$id');
    final response = await http.delete(url);
    return response;
  }

  Future<http.Response> query(String path, String id) async {
    final url = Uri.parse('$baseUrl$path/$id');
    final response = await http.get(url);
    return response;
  }
}
