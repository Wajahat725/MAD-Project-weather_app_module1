class Forecast {
  final String city;
  final double temperature;
  final double humidity;
  final String condition;
  final double windSpeed; // Add wind speed
  final double pressure;  // Add pressure

  Forecast(
      this.city,
      this.temperature,
      this.humidity,
      this.condition,
      this.windSpeed, // Add to constructor
      this.pressure,  // Add to constructor
      );
}