import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app/ui/pages/history_page.dart';
import '../../services/weather_service.dart';
import '../../models/weather_model.dart';
import '../widgets/weather_info.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();
  final WeatherService _weatherService = WeatherService();
  WeatherModel? _weather;
  String _error = '';

  void _searchWeather(String city) async {
    if (city.isEmpty) return;

    final weather = await _weatherService.getWeather(city);
    setState(() {
      if (weather != null) {
        _weather = weather;
        _error = '';
      } else {
        _error = 'Cidade não encontrada';
        _weather = null;
      }
    });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Previsão do Tempo')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 133, 133, 133),
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(255, 80, 80, 80).withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Autocomplete<String>(
                optionsBuilder: (TextEditingValue textEditingValue) async {
                  if (textEditingValue.text.length < 2) return [];
                  return await getCitySuggestions(textEditingValue.text);
                },
                onSelected: (String selection) {
                  _controller.text = selection;
                  _searchWeather(selection);
                },
                fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
                  _controller.text = controller.text;
                  return TextField(
                    controller: controller,
                    focusNode: focusNode,
                    decoration: const InputDecoration(
                      hintText: 'Digite a cidade',
                      border: InputBorder.none,
                      icon: Icon(Icons.location_city),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _searchWeather(_controller.text.trim()),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(100, 50),
                backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
              child: const Text(
                'Buscar',
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                MaterialPageRoute(builder: (context) => const HistoryPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                padding : const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                minimumSize: const Size(100, 50),
                backgroundColor: const Color.fromARGB(255, 0, 0, 0),
              ),
              child: const Text('Ver Histórico',
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center,),
            ),
            
            const SizedBox(height: 32),
            if (_error.isNotEmpty)
              Text(_error, style: const TextStyle(color: Colors.red)),
            if (_weather != null) WeatherInfo(weather: _weather!),
          ],
        ),
      ),
    );
  }
}
