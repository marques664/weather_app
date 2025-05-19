import 'package:flutter/material.dart';
import '../../models/weather_model.dart';

class WeatherInfo extends StatelessWidget {
  final WeatherModel weather;

  const WeatherInfo({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
      color: Color.fromARGB(255, 133, 133, 133),
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
        color: const Color.fromARGB(255, 133, 133, 133).withOpacity(0.7),
        blurRadius: 8,
        offset: Offset(0, 4),
        ),
      ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
      children: [
        Text(
        '${weather.temperature.toStringAsFixed(0)}°C',
        style: TextStyle(fontSize: 40, color: const Color.fromARGB(255, 0, 0, 0)),
        ),
        Text(
        weather.description,
        style: TextStyle(fontSize: 20, color: Colors.black),
        ),
        const SizedBox(height: 16),
        Image.network(
        'http://openweathermap.org/img/wn/${weather.icon}@2x.png',
        ),
      ],
      ),
    );
  }
}
