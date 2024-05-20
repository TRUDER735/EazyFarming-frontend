import 'package:crop/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class WeatherBar extends StatefulWidget {
  const WeatherBar({super.key});

  @override
  State<WeatherBar> createState() => _WeatherBarState();
}

class _WeatherBarState extends State<WeatherBar> {
  dynamic _weather;

  Future<dynamic> getWeather() async {
    dynamic response = await Weather().getWeather('location');
    return response;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getWeather(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          _weather = snapshot.data;
          String iconCode = _weather['weather'][0]['icon'].toString();
          String description = _weather['weather'][0]['description'].toString();
          String humidity = _weather['main']['humidity'].toString();
          String wind = _weather['wind']['speed'].toString();
          String temp = _weather['main']['temp'].toString();

          return Container(
            padding: const EdgeInsets.all(16.0),
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 221, 221, 221),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Current weather : $description',
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Image.network(
                            'http://openweathermap.org/img/wn/$iconCode@2x.png',
                            width: 100,
                            height: 100,
                          ),
                          const SizedBox(
                            width: 16.0,
                          ),
                          Text(
                            '$temp °C',
                            style: const TextStyle(
                              fontSize: 22.0,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                const Text('Humidity'),
                                Text(
                                    '$humidity %')
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                const Text('Wind'),
                                Text(
                                    '$wind m/s')
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          );
        }
      },
    );
  }
}
