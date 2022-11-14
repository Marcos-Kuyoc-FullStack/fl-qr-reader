import 'package:flutter/material.dart';

import 'screens/screens.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QR Reader',
      initialRoute: 'home',
      routes: {
        'home': (_) => const HomeScreen(),
        'mapa': (_) => const MapaScreen(),
      },
    );
  }
}
