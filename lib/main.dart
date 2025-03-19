import 'package:flutter/material.dart';
import 'package:pet_plan_pruebas/pantalla_login.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

const supabaseUrl = 'https://fzukoqnipqclppkpotbc.supabase.co';
const supabaseKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImZ6dWtvcW5pcHFjbHBwa3BvdGJjIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mzk4NzQ5ODAsImV4cCI6MjA1NTQ1MDk4MH0.Y7fmZFE3SiXvaSaYYNB1Y_WuWvAXNnA9Xdg0aJxEjjc';

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
