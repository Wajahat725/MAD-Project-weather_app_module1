import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

/// Main function – entry point of the Dart program
void main() {
  // Variable examples (Data types)
  int temperature = 25;
  double humidity = 60.5;
  String city = "Islamabad";
  bool isSunny = true;

  // Operators
  var comfort = (temperature > 20 && humidity < 70) ? "Comfortable" : "Humid";

  print("Weather in $city is $comfort");

  // Run Flutter App
  runApp(const WeatherlyApp());
}

/// MaterialApp Root Widget
class WeatherlyApp extends StatelessWidget {
  const WeatherlyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weatherly App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomeScreen(),
    );
  }
}