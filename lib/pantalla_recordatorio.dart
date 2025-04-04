import 'package:flutter/material.dart';

class PantallaRecordatorio extends StatelessWidget {
  final String recordatorio;

  PantallaRecordatorio({required this.recordatorio});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Detalle del Recordatorio")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            recordatorio,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
