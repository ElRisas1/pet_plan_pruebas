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
      backgroundColor: const Color.fromARGB(248, 144, 177, 235),
      body: contenido(),
    );
  }

  Widget contenido(){
    return Stack(
      children: [
        // Appbar
        AppBar(title: Text(widget.nombreMascota), 
      ),

      // TITULO DE LA PANTALLA
      Padding(
        padding: const EdgeInsets.only(top: 90, left: 160 ), // Ajusta el espacio superior para evitar que se solape con el AppBar
        child: Text(
               widget.nombreMascota,
              style: const TextStyle(
                fontSize: 30,
                color: Color.fromARGB(218, 0, 0, 0),
                fontWeight: FontWeight.bold, // Puedes cambiar el peso para que se vea más destacado
              ),
            ),
      ),
      
       // IMAGEN DE PERFIL MASCOTA - CENTRADA
      Positioned(
        top: 150, 
        left: 160, 
        child: Material(
          elevation: 8, // Agrega sombra al botón
          shape: const CircleBorder(), // Mantiene la forma circular
          clipBehavior: Clip.antiAlias, // Suaviza los bordes del círculo

          child: Container(
            padding: const EdgeInsets.all(4), // Espaciado para el borde
            decoration: BoxDecoration(
              shape: BoxShape.circle, // Hace que el borde sea redondo
              border: Border.all(color: Colors.white, width: 2.5), // Borde blanco
            ),

            child: InkWell(
              splashColor: Colors.black26, // Efecto al tocar
              // onTap
              child: CircleAvatar( // Hace la imagen redonda
              radius: 50,
              backgroundImage: AssetImage('assets/profile_pic.png'),
              ),
            ),
          ),
        ),
      ),

      ],//Children
    );
  }
}
