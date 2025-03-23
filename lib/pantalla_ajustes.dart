import 'package:flutter/material.dart';

class PantallaAjustes extends StatefulWidget {
  

  // Constructor
  const PantallaAjustes({super.key, required String title});

  @override
  _PantallaAjustesState createState() => _PantallaAjustesState();
}

class _PantallaAjustesState extends State<PantallaAjustes> {

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(248, 152, 184, 239),
      appBar: AppBar(title: Text("Ajustes")),
      body: Center(
        child: Text(
          "Ajustes de la app",
          style: TextStyle(fontSize: 25),
        ),
      ),
    );
  }
}