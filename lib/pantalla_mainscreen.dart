import 'package:flutter/material.dart';

class PantallaPrincipal extends StatefulWidget {
  const PantallaPrincipal({super.key, required this.title});

  final String title;

  @override
  State<PantallaPrincipal> createState() => _PantallaPrincipalState();
}

class _PantallaPrincipalState extends State<PantallaPrincipal> {

  //AQUI VAN LAS VARIABLES GLOBALES//

  @override
  void initState(){
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
      return  Scaffold( backgroundColor: const Color.fromARGB(249, 249, 230, 122),
        body: SingleChildScrollView(child:Column(mainAxisAlignment: MainAxisAlignment.center,
            children:[
              const Divider(height: 80),

              const Text("Mis Mascotas", style: TextStyle(fontSize: 40, color: Color.fromARGB(255, 226, 138, 23))),
              Padding(padding: EdgeInsets.all(20)),

              SizedBox(
                height: 200.0,
                width: 200.0,
                child: Image.asset("assets/logoLorena.png")

              ),
             ] //Children  
        )
        )
      );
  } //Build
} //Final de la class