import 'package:estagio_aiko/controle/util_shared_preferences.dart';
import 'package:estagio_aiko/telas/home_tela.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Programa estágio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFF54a2de),
        accentColor: Colors.blueAccent,
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeTela(),
    );
  }
}
