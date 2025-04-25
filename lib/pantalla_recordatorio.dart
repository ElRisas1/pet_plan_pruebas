import 'package:flutter/material.dart';

class PantallaRecordatorio extends StatelessWidget {
  final String recordatorio;

  PantallaRecordatorio({required this.recordatorio});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(248, 152, 184, 239), // Fondo azul claro
      body: content(),
    );
  }

  Widget content() {
    //double screenWidth = MediaQuery.of(context).size.width;
    //double screenHeight = MediaQuery.of(context).size.height;
    
    return Stack(
      children: [
        AppBar(
          title: Text("Recordatorio"),
          backgroundColor: Color.fromARGB(248, 238, 220, 138), // Fondo azul claro
        ),
        Positioned(
          top: 100,
          left: 25,
          right: 25,
          child: Container(
            height: 750,
              decoration: BoxDecoration(
                color: Colors.white, //fondo blanco de la lista
                borderRadius: BorderRadius.circular(10), //bordes redondeados
                 boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0, 2),
                  )
                ]
              ) 
          ),
        )
      ],
    );

  }
}
