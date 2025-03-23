import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class PantallaMascota extends StatefulWidget {
  final String nombreMascota;

  // Constructor
  const PantallaMascota({super.key, required this.nombreMascota, required String title});

  @override
  _PantallaMascotaState createState() => _PantallaMascotaState();
}

class _PantallaMascotaState extends State<PantallaMascota> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.nombreMascota)),
      body: Center(
        child: Text(
          "Detalles de ${widget.nombreMascota}",
          style: TextStyle(fontSize: 25),
        ),
      ),
    );
  }
}
