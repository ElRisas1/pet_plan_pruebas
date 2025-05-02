 import 'package:flutter/material.dart';
import 'pantalla_nuevoRecordatorio.dart';

class PantallaRecordatorio extends StatelessWidget {
  final String recordatorio;

  PantallaRecordatorio({required this.recordatorio});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(248, 152, 184, 239),
      body: content(context),
    );
  }

  Widget content(BuildContext context) {
    return Stack(
      children: [
        AppBar(
          title: Text("Recordatorio"),
          backgroundColor: Color.fromARGB(248, 238, 220, 138),
        ),
        Positioned(
          top: 100,
          left: 25,
          right: 25,
          child: Container(
            height: 750,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  offset: Offset(0, 2),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 30,
          right: 30,
          child: ElevatedButton(
            onPressed: () {
              // Cambiar de pantalla
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PantallaNuevoRecordatorio(title: "Nuevo recordatorio"),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.amber, // Color de fondo del botón
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            ),
            child: Text("Crear recordatorio", style: TextStyle(fontSize: 16)),
          ),
        ),
      ],
    );
  }
}

