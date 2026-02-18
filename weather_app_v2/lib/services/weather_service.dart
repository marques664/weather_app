import 'dart:convert';

import 'package:weather_app_v2/models/weather_model.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class WeatherService {
  static const BASE_URL = 'https://api.openweathermap.org/data/2.5/weather';
  final String apiKey;

  WeatherService(this.apiKey);

Future<Weather> getWeatherByLocation() async {
  LocationPermission permission = await Geolocator.checkPermission();

  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
  }

  if (permission == LocationPermission.deniedForever) {
    throw Exception("Location permission denied forever");
  }

  final position = await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.high,
  );

  final response = await http.get(
    Uri.parse(
      '$BASE_URL?lat=${position.latitude}&lon=${position.longitude}&appid=$apiKey&units=metric&lang=pt_br',
    ),
  );

  if (response.statusCode == 200) {
    return Weather.fromJson(jsonDecode(response.body));
  } else {
    throw Exception(
      "Failed to load weather data: ${response.statusCode} - ${response.body}",
    );
  }
}


  Future<Weather> getWeather(String cityName) async {

    if(cityName.isEmpty) {
      throw Exception("City name cannot be empty (geocoding returned null).");
    }

    final response = await http.get(
      Uri.parse('$BASE_URL?q=$cityName&appid=$apiKey&units=metric'),
    );

    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to load weather data: ${response.statusCode} - ${response.body}",);
    }
  }

  Future<String> getCurrentCity() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    final place = placemarks[0];

    final city = place.locality ??
      place.subAdministrativeArea ??
      place.administrativeArea ??
      place.name;

    return city ?? "";
  }
}
