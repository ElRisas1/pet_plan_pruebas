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
    return Scaffold(
      backgroundColor: const Color.fromARGB(248, 152, 184, 239),
      appBar: AppBar(title: Text("Nombre Usuario")), 
     // backgroundColor: const Color.fromARGB(248, 238, 220, 138),
      body: Center(
        child: Text(
          "Perfil Usuario",
          style: TextStyle(fontSize: 25),
        ),
      ),
    );
  }
}