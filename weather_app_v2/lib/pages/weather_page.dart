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
  final TextEditingController _searchController = TextEditingController();
  bool _showSearchField = false;

  _fetchWeather() async {
    try {
      final weather = await _weatherService.getWeatherWithFallback();
      setState(() {
        _weather = weather;
        _showSearchField = false;
      });
    } catch (e) {
      print(e);
      setState(() {
        _showSearchField = true;
      });
    }
  }

  _searchWeatherByCity(String cityName) async {
    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
        _showSearchField = false;
        _searchController.clear();
      });
    } catch (e) {
      print(e);
      _showErrorSnackbar('Cidade não encontrada: $e');
    }
  }

  _showErrorSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red[700],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
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
        return 'assets/windy.json';
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: _weather == null
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Header com localização e botão de busca
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.location_on,
                                size: 34,
                                color: Colors.grey[500],
                              ),
                              Text(
                                _weather?.cityName ?? "",
                                style: TextStyle(
                                  fontSize: 36,
                                  fontFamily: 'Oswald',
                                  color: Colors.grey[500],
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              _showSearchField = !_showSearchField;
                              _searchController.clear();
                            });
                          },
                          icon: Icon(
                            _showSearchField ? Icons.close : Icons.search,
                            color: Colors.grey[500],
                            size: 28,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    // Campo de busca (aparece quando solicitado)
                    if (_showSearchField)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: TextField(
                          controller: _searchController,
                          style: TextStyle(color: Colors.grey[300]),
                          textInputAction: TextInputAction.search,
                          onSubmitted: (value) {
                            if (value.isNotEmpty) {
                              _searchWeatherByCity(value);
                            }
                          },
                          decoration: InputDecoration(
                            hintText: 'Digite o nome da cidade...',
                            hintStyle: TextStyle(color: Colors.grey[600]),
                            prefixIcon: Icon(
                              Icons.location_city,
                              color: Colors.grey[500],
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                Icons.send,
                                color: Colors.grey[500],
                              ),
                              onPressed: () {
                                if (_searchController.text.isNotEmpty) {
                                  _searchWeatherByCity(_searchController.text);
                                }
                              },
                            ),
                            filled: true,
                            fillColor: Colors.grey[800],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.grey[700]!),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.grey[700]!),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.grey[500]!),
                            ),
                          ),
                        ),
                      ),

                    const Spacer(),

                    // Animação do clima
                    Center(
                      child: SizedBox(
                        height: 220,
                        width: 220,
                        child: Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),
                      ),
                    ),

                    const Spacer(),

                    // Temperatura e condição
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Column(
                        children: [
                          Text(
                            "${_weather!.temperature.toStringAsFixed(1)}°C",
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: 42,
                              fontFamily: 'Oswald',
                            ),
                          ),
                          Text(
                            _weather?.mainCondition ?? "",
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
