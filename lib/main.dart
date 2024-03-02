import 'package:flutter/material.dart';
import 'package:weather_report/login.dart';
import 'package:weather_report/ui.dart';
import 'package:weather_report/view/weather.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo', theme: ThemeData(), 
        home:LoginPage());
  }
}
