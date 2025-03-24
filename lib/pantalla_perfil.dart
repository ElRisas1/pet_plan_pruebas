import 'package:flutter/material.dart';

class PantallaPerfil extends StatefulWidget {

  final String nombreUser;

  // Constructor
  const PantallaPerfil({super.key, required this.nombreUser, required String title});

  @override
  _PantallaPerfilState createState() => _PantallaPerfilState();
}

class _PantallaPerfilState extends State<PantallaPerfil> {

  
   @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Transform.translate(
            offset: Offset(0, -200), // Mueve la imagen 50 px hacia arriba
            child:ClipOval(
            child: Image.asset(
              ("assets/profile_pic.png"),
              width: 200,
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    ),
  );
}
}
