import 'package:flutter/material.dart';

//Pantallas

// Pantalla para agregar mascota
class PantallaAgregarMascota extends StatelessWidget {
  const PantallaAgregarMascota({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Agregar Mascota')),
      body: const Center(
        child: Text('Formulario para agregar mascota'),
      ),
    );
  }
}