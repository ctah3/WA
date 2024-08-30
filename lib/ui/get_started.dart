import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class WeatherApp extends StatefulWidget {
  @override
  _WeatherAppState createState() => _WeatherAppState();
}

class WeatherService {
  final String apiUrl = 'https://wttr.in';

  Future<Map<String, dynamic>> fetchWeather(String location) async {
    final response = await http.get(Uri.parse('$apiUrl/$location?format=j1'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}


class _WeatherAppState extends State<WeatherApp> {
  late Future<Map<String, dynamic>> weatherData;

  @override
  void initState() {
    super.initState();
    weatherData = WeatherService().fetchWeather('London');
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'icons/Image.png',
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF3A3F54).withOpacity(0.2),
                    Color(0xFF373F63).withOpacity(1),
                  ],
                  stops: [0.2, 0.5],
                  begin: Alignment.center,
                  end: Alignment.bottomCenter,

                ),
              ),
            ),
          ),

      Center(
        child: FutureBuilder<Map<String, dynamic>>(
          future: weatherData,
          builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
    return CircularProgressIndicator();
    } else if (snapshot.hasError) {
    return Text('Error: ${snapshot.error}');
    } else if (!snapshot.hasData) {
    return Text('No data found');
    } else {
    final data = snapshot.data!;
    final currentCondition = data['current_condition'][0];
    return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
    Text('London', style: TextStyle(fontSize: 24, color: Colors.white)),
    Text('${currentCondition['temp_C']}°C', style: TextStyle(fontSize: 40, color: Colors.white)),
    Text('${currentCondition['weatherDesc'][0]['value']}', style: TextStyle(fontSize: 20, color: Colors.white)),
    Image.asset(
    'icons/house.png',
    width: size.width * 0.8,
    height: size.width * 0.8,),
            const SizedBox(height: 30,),
            Container(
            height: 50,
            width: size.width * 0.9,
            decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            ),
            ],

    );
    }
    },

    ),
    ),
    ],
      ),
    );
    }
    }


