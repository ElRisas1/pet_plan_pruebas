import 'package:flutter/material.dart';

class PantallaRegistro extends StatefulWidget {
  const PantallaRegistro({super.key, required this.title});

  final String title;

  @override
  State<PantallaRegistro> createState() => _PantallaRegistroState();
}


class _PantallaRegistroState extends State<PantallaRegistro> {

  @override
  void initState(){
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return  Scaffold( backgroundColor: const Color.fromARGB(100, 152, 184, 239),
        body: SingleChildScrollView(child:Column(mainAxisAlignment: MainAxisAlignment.center,
            children:[
              const Divider(height: 80),

              const Text("Pantalla de registro", style: TextStyle(fontSize: 17, color: Colors.black),)
            ]
          )
        )
      );
  }
}