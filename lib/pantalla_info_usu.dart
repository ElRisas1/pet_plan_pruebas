import 'package:flutter/material.dart';

class PantallaInfoUsu extends StatefulWidget {

  // VARIABLES //
 

  // Constructor
  const PantallaInfoUsu({super.key, required String title});

  @override
  _PantallaInfoUsuState createState() => _PantallaInfoUsuState();
}

class _PantallaInfoUsuState extends State<PantallaInfoUsu> {

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(248, 238, 220, 138),
      appBar: AppBar(title: Text("Tu Información")),
      body: Center(
        child: Text(
          "Informacion d la pantalla",
          style: TextStyle(fontSize: 25),
        ),
      ),
    );
  }
}