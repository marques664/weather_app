import 'package:flutter/material.dart';
import 'ui/pages/home_page.dart';

void main() {
  runApp(const ClimaApp());
}

class ClimaApp extends StatelessWidget {
  const ClimaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clima App',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark, // tema escuro
      darkTheme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 32, 32, 32),
        primaryColor: const Color.fromARGB(255, 255, 255, 255),
        textTheme: const TextTheme(
        bodyLarge: TextStyle(color: Colors.white),
        bodyMedium: TextStyle(color: Colors.white),
        titleLarge: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          hintStyle: TextStyle(color: Colors.white70),
        ),
      ),
      home: HomePage(),
    );
  }
}
