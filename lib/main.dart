import 'package:flutter/material.dart';
import 'package:pet_plan_pruebas/pantalla_main.dart';
import 'package:pet_plan_pruebas/pantalla_login.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

const supabaseUrl = 'https://fzukoqnipqclppkpotbc.supabase.co';
const supabaseKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImZ6dWtvcW5pcHFjbHBwa3BvdGJjIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mzk4NzQ5ODAsImV4cCI6MjA1NTQ1MDk4MH0.Y7fmZFE3SiXvaSaYYNB1Y_WuWvAXNnA9Xdg0aJxEjjc';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: supabaseUrl,
    anonKey: supabaseKey,
  );

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PetPlan',
      debugShowCheckedModeBanner: false, // opcional: elimina la etiqueta DEBUG
      initialRoute: '/login',
      routes: {
        '/login': (context) => const PantallaLogin(title: "Pantalla p"),
        '/main': (context) => const PantallaPrincipal(title: "PantallaPrincipal"),
      },
    );
  }
}
