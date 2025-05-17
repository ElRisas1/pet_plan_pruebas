import 'package:flutter/material.dart';

class PantallaEditarMascota extends StatefulWidget {

  // VARIABLES //
  final String nombreMascota;

  // Constructor
  const PantallaEditarMascota({super.key,  required this.nombreMascota,required String title});

  @override
  _PantallaEditarMascotaState createState() => _PantallaEditarMascotaState();
}

class _PantallaEditarMascotaState extends State<PantallaEditarMascota> {

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(248, 238, 220, 138),
      appBar: AppBar(title: Text("Editar")),
      body: Center(
        child: Text(
          "Contenido de la pantalla",
          style: TextStyle(fontSize: 25),
        ),
      ),
    );
  }
}
  