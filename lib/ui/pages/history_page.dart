import 'package:flutter/material.dart';
import 'package:weather_app/services/city_history.dart';


class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Histórico de Cidades'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(8.0),
        child: CityHistoryWidget(),
      ),
    );
  }
}
