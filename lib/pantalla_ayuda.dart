import 'package:flutter/material.dart';

class PantallaAyuda extends StatefulWidget {
 

  // Constructor
  const PantallaAyuda({super.key, required String title});

  @override
  _PantallaAyudaState createState() => _PantallaAyudaState();
}

class _PantallaAyudaState extends State<PantallaAyuda> {

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(248, 152, 184, 239),
      appBar: AppBar(title: Text("Ayuda")),
      body: Center(
        child: Text(
          "Ayuda",
          style: TextStyle(fontSize: 25),
        ),
      ),
    );
  }
}