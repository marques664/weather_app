// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import '../firebase_options.dart';

class WeatherService {
  final String apiKey = 'API_KEY_HERE';

  Future<WeatherModel?> getWeather(String city) async {
    final url =
        'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric&lang=pt_br';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(response.body);
      print('Salvando cidade: $city');
      await saveCitySearch(city);
      return WeatherModel.fromJson(jsonBody);
    } else {
      print('Erro: ${response.statusCode} - ${response.body}');
      return null;
    }
  }

Future<void> saveCitySearch(String cityName) async {
  try {
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
    }

    await FirebaseFirestore.instance.collection('city_history').add({
      'city': cityName,
      'timestamp': Timestamp.now(),
    });

    print('Cidade salva com sucesso!');
  } catch (e) {
    print('Erro ao salvar cidade: $e');
  }
}


  Future<List<String>> getCitySuggestions(String query) async {
  final url = Uri.parse(
    'https://api.openweathermap.org/geo/1.0/direct?q=$query&limit=5&appid=e651585d10115a5e080128ecfb33ed5f',
  );
  final response = await http.get(url);

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    return List<String>.from(
      data.map((city) =>
          '${city['name']}, ${city['state'] ?? ''}, ${city['country']}'),
    );
  } else {
    return [];
  }
}
}
