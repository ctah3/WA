import 'package:flutter/material.dart';
import 'ui/get_started.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      home: WeatherApp(),
      debugShowCheckedModeBanner: false,
    );
  }
}
