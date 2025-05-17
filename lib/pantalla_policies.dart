import 'package:flutter/material.dart';

class PantallaPolicies extends StatelessWidget {
  final String nombreMascota;

  const PantallaPolicies({super.key, required this.nombreMascota, required String title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 174, 202, 255),
      appBar: AppBar(
        title: const Text("Policies"),
        backgroundColor: const Color.fromARGB(255, 174, 202, 255),
        elevation: 0,
        foregroundColor: Colors.black87,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              // Caja blanca con contenido (margen arriba para dejar espacio a las imágenes)
              Container(
                margin: const EdgeInsets.fromLTRB(30, 80, 30, 20),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.deepPurpleAccent, width: 3),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 8,
                      offset: Offset(2, 4),
                    ),
                  ],
                ),
                child: const Column(
                  children: [
                    SizedBox(height: 30), // Para que no se superponga con las mascotas
                    Text(
                      "Things to keep in mind!",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepOrange,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    Text(
                      "WE DON'T SHARE DATA WITH THIRD PARTIES.",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    Text(
                      "OUR COMPANY DOES NOT TAKE ACCOUNTABILITY\nFOR ANY ADVICE GIVEN BY OUR AI CHAT.",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

              // Mascotas encima
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/cat.png', width: 60),
                  const SizedBox(width: 20),
                  Image.asset('assets/dog.png', width: 60),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

