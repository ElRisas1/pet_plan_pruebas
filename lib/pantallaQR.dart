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
      backgroundColor: const Color.fromARGB(248, 238, 220, 138),
      appBar: AppBar(title: Text("Nuevo recordatorio")),
      body: Center(
        child: Text(
          "Aquí va el QR",
          style: TextStyle(fontSize: 25),
        ),
      ),
    );
  }
}
  