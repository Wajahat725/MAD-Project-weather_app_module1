import 'package:flutter/material.dart';
import '../models/weather.dart';

class WeatherCard extends StatelessWidget {
  final Forecast forecast;

  const WeatherCard({super.key, required this.forecast});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white70,
      margin: const EdgeInsets.all(20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(forecast.city, style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
            Text("${forecast.temperature}°C", style: const TextStyle(fontSize: 40)),
            Text("Humidity: ${forecast.humidity}%", style: const TextStyle(fontSize: 18)),
            Text("Condition: ${forecast.condition}", style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
