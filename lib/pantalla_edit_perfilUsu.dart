import 'package:flutter/material.dart';

class PantallaEditPerfilUsu extends StatefulWidget {

  // VARIABLES //
  

  // Constructor
  const PantallaEditPerfilUsu({super.key, required String title});

  @override
  _PantallaEditPerfilUsuState createState() => _PantallaEditPerfilUsuState();
}

class _PantallaEditPerfilUsuState extends State<PantallaEditPerfilUsu> {

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(248, 238, 220, 138),
      appBar: AppBar(title: Text("Editar Perfil")),
      body: Center(
        child: Text(
          "Contenido de la pantalla",
          style: TextStyle(fontSize: 25),
        ),
      ),
    );
  }
}
  