import 'package:flutter/material.dart';
import '../models/weather.dart';
import '../widgets/weather_card.dart';
import '../widgets/animated_sun.dart';
import '../widgets/animated_cloud.dart';
import '../widgets/app_background.dart';
import 'dart:math';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Controller for the search text field
  final TextEditingController _searchController = TextEditingController();

  // Default forecast with all parameters
  Forecast forecast = Forecast("Islamabad", 27.0, 65.0, "Sunny", 15.0, 1013.0);

  // Simulated weather data (like a mini database) with complete data
  final Map<String, Forecast> cityWeather = {
    "islamabad": Forecast("Islamabad", 27.0, 65.0, "Sunny", 15.0, 1013.0),
    "lahore": Forecast("Lahore", 33.0, 70.0, "Hot", 12.0, 1010.0),
    "karachi": Forecast("Karachi", 30.0, 75.0, "Humid", 18.0, 1008.0),
    "peshawar": Forecast("Peshawar", 28.0, 60.0, "Partly Cloudy", 20.0, 1012.0),
    "quetta": Forecast("Quetta", 22.0, 50.0, "Cool Breeze", 25.0, 1015.0),
    "murree": Forecast("Murree", 18.0, 85.0, "Foggy", 8.0, 1005.0),
  };

  // Function to search city
  void _searchCity() {
    String input = _searchController.text.trim().toLowerCase();
    setState(() {
      forecast = cityWeather[input] ??
          Forecast("Unknown", 0.0, 0.0, "City not found 😢", 0.0, 0.0);
    });
  }

  // Function to refresh weather data (simulate real API call)
  void _refreshWeather() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Refreshing Weather...'),
        backgroundColor: Colors.blueAccent.withOpacity(0.95),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        duration: const Duration(seconds: 2),
      ),
    );

    // Simulate API delay and update with slight random variations
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        // Get current city data
        final currentCity = forecast.city.toLowerCase();
        final baseData = cityWeather[currentCity] ?? cityWeather["islamabad"]!;

        // Add small random variations to simulate real weather changes
        final random = Random();
        forecast = Forecast(
          baseData.city,
          baseData.temperature + (random.nextDouble() * 2 - 1), // ±1°C variation
          baseData.humidity + (random.nextDouble() * 5 - 2.5), // ±2.5% variation
          baseData.condition,
          baseData.windSpeed + (random.nextDouble() * 3 - 1.5), // ±1.5 km/h variation
          baseData.pressure + (random.nextDouble() * 2 - 1), // ±1 hPa variation
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              "https://images.unsplash.com/photo-1504608524841-42fe6f032b4b?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1965&q=80",
            ),
            fit: BoxFit.cover,
            alignment: Alignment.center,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                // Custom App Bar
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  decoration: BoxDecoration(
                    color: Colors.blueAccent.withOpacity(0.9),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Text(
                    'Weather 🌦️',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // 🔍 Search Bar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                blurRadius: 15,
                                offset: const Offset(0, 6),
                              ),
                            ],
                          ),
                          child: TextField(
                            controller: _searchController,
                            decoration: InputDecoration(
                              hintText: "Enter city name...",
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.95),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide.none,
                              ),
                              prefixIcon: const Icon(Icons.search, color: Colors.blueAccent),
                              contentPadding: const EdgeInsets.symmetric(vertical: 15),
                              hintStyle: const TextStyle(color: Colors.grey),
                            ),
                            onSubmitted: (_) => _searchCity(),
                            style: const TextStyle(color: Colors.black87, fontSize: 16),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.4),
                              blurRadius: 12,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: ElevatedButton(
                          onPressed: _searchCity,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent,
                            shape: const CircleBorder(),
                            padding: const EdgeInsets.all(16),
                          ),
                          child: const Icon(Icons.check, color: Colors.white, size: 24),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 40),

                // 🌞 Animated Sun
                const AnimatedSun(),

                const SizedBox(height: 30),

                // 🧾 Weather Card
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.4),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: WeatherCard(forecast: forecast),
                  ),
                ),

                const SizedBox(height: 30),

                // ☁️ Animated Cloud
                const AnimatedCloud(),

                const SizedBox(height: 40),

                // Refresh Button
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.4),
                        blurRadius: 15,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: ElevatedButton.icon(
                    onPressed: _refreshWeather, // Use the new refresh function
                    icon: const Icon(Icons.refresh, size: 24),
                    label: const Text("Refresh", style: TextStyle(fontSize: 16)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white.withOpacity(0.95),
                      foregroundColor: Colors.blueAccent,
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                // Additional Weather Info Section - NOW DYNAMIC
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'Weather Details',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent,
                        ),
                      ),
                      const SizedBox(height: 15),
                      // Dynamic weather details that change with city
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              const Icon(Icons.air, color: Colors.blue),
                              const Text('Wind', style: TextStyle(fontSize: 12)),
                              Text('${forecast.windSpeed.toStringAsFixed(1)} km/h',
                                  style: const TextStyle(fontWeight: FontWeight.bold)),
                            ],
                          ),
                          Column(
                            children: [
                              const Icon(Icons.water_drop, color: Colors.blue),
                              const Text('Humidity', style: TextStyle(fontSize: 12)),
                              Text('${forecast.humidity.toStringAsFixed(1)}%',
                                  style: const TextStyle(fontWeight: FontWeight.bold)),
                            ],
                          ),
                          Column(
                            children: [
                              const Icon(Icons.compress, color: Colors.blue),
                              const Text('Pressure', style: TextStyle(fontSize: 12)),
                              Text('${forecast.pressure.toStringAsFixed(0)} hPa',
                                  style: const TextStyle(fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 60),
              ],
            ),
          ),
        ),
      ),
    );
  }
}