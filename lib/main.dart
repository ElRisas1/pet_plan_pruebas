import 'package:flutter/material.dart';
import 'package:pet_plan_pruebas/pantalla_login.dart';


void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Juego de tronos personaje',
      home: PantallaLogin(title: "Pantalla Login"),
    );
  }
}
