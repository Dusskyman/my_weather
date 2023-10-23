import 'package:flutter/material.dart';
import 'package:my_weather/pages/map_page/map_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MapPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
