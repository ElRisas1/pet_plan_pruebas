import 'package:flutter/material.dart';

class PantallaNuevoRecordatorio extends StatefulWidget {
 

  // Constructor
  const PantallaNuevoRecordatorio({super.key, required String title});

  @override
  _PantallaNuevoRecordatorioState createState() => _PantallaNuevoRecordatorioState();
}

class _PantallaNuevoRecordatorioState extends State<PantallaNuevoRecordatorio> {

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(248, 152, 184, 239),
      appBar: AppBar(title: Text("Nuevo recordatorio")),
      body: Center(
        child: Text(
          "Recordatorio",
          style: TextStyle(fontSize: 25),
        ),
      ),
    );
  }
}