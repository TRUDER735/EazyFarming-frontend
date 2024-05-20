import 'dart:convert';

import 'package:http/http.dart' as http;
class Weather {

  Future getWeather(location) async{
    final url = Uri.parse('https://api.openweathermap.org/data/2.5/weather?lat=-17.824858&lon=31.053028&appid=105aa9cfac9fa18c78c11ae02ea1b6df&units=metric');
    final response = await http.get(url);
    return jsonDecode(response.body);
  }
}
