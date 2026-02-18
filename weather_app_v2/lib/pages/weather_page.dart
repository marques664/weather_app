import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app_v2/services/weather_service.dart';
import 'package:weather_app_v2/models/weather_model.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _weatherService = WeatherService("API_KEY_HERE");
  Weather? _weather;

  _fetchWeather() async {
    try {
      final weather = await _weatherService.getWeatherByLocation();
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return 'assets/sunny.json';

    switch (mainCondition.toLowerCase()){
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/cloudy.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/shower.json';
      case 'thunderstorm':
        return 'assets/storm.json';
      case 'clear':
        return 'assets/sunny.json';

      default:
        return 'assets/sunny.json';
    }
  }

  @override
  void initState() {
    super.initState();

    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: SafeArea(
        child: Padding(padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: _weather == null
            ? const Center(child: CircularProgressIndicator())
            : Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 34,
                          color: Colors.grey[500],
                        ),
                        Text(_weather?.cityName ?? "",
                      style: TextStyle(
                      fontSize: 36,
                      fontFamily: 'Oswald',
                      color: Colors.grey[500]
                      ),
                    ),
                  ]),
                ),

                  const Spacer(),

                  Center(
                    child: SizedBox(
                      height: 220,
                      width: 220,
                      child: Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),
                    ),
                  ),

                  const Spacer(),
              
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      _weather == null
                        ? "Loading city..."
                        : "${_weather!.temperature.toStringAsFixed(1)}°C",
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 42,
                          fontFamily: 'Oswald',                         
                        ),
                    ),
                  ),
        
              Text(_weather?.mainCondition ?? ""),
            ],
          ),
      ),
      )
    );
  }
}
