import 'package:flutter/material.dart';

class PantallaQR extends StatefulWidget {

  // VARIABLES //
  final String nombreMascota;

  // Constructor
  const PantallaQR({super.key,  required this.nombreMascota,required String title});

  @override
  _PantallaQRState createState() => _PantallaQRState();
}

class _PantallaQRState extends State<PantallaQR> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("QR ${widget.nombreMascota}"),
       // backgroundColor: Colors.blue, // Cambia el color si quieres
      ),
      backgroundColor: const Color.fromARGB(248, 238, 220, 138),
      body: contenido(),
    );
  }

  Widget contenido(){
    return Stack(
      
    );
  }
}