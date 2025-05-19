class WeatherModel {
  final String description;
  final double temperature;
  final String icon;

  WeatherModel({
    required this.description,
    required this.temperature,
    required this.icon,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      description: json['weather'][0]['description'],
      temperature: json['main']['temp'].toDouble(),
      icon: json['weather'][0]['icon'],
    );
  }
}
