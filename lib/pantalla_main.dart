import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:pet_plan_pruebas/pantalla_mascota.dart';


class PantallaPrincipal extends StatefulWidget {
  const PantallaPrincipal({super.key, required this.title});

  final String title;

  @override
  State<PantallaPrincipal> createState() => _PantallaPrincipalState();
}

class _PantallaPrincipalState extends State<PantallaPrincipal> {
  
  final List<String> mascotas = ["Firulais", "Luna", "Max"]; // Lista de mascotas

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(248, 238, 220, 138),
      body: content(),
    );
  }

Widget content() {
  return Stack(
    children: [
      // Imagen de perfil en la esquina superior derecha
      Positioned(
        // Margenes
        top: 40, 
        right: 20, 
        child: InkWell(
          splashColor: Colors.black26, // Efecto al tocar
          onTap: () {
            print("Perfil presionado"); // prueba de que es presionable
          },
          child: ClipOval( // esto hace la imagen redonda
            child: Image.asset(
              'assets/logolorena.png', 
              // Tamaño de la imagen
              width: 80, 
              height: 80,
              fit: BoxFit.cover, // esto ajusta la imagen al círculo
            ),
          ),
        ),
      ),

      // Contenedor con el carrusel de mascotas
      Container(
        margin: const EdgeInsets.only(left: 15, top: 350, bottom: 20),
        child: CarouselSlider(
          items: mascotas.map((mascota) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PantallaMascota(nombreMascota: mascota, title: ''),
                  ),
                );
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 7),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 232, 236, 239),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    mascota,
                    style: const TextStyle(fontSize: 35),
                  ),
                ),
              ),
            );
          }).toList(),
          options: CarouselOptions(
            height: 150,
            enlargeCenterPage: true,
          ),
        ),
      ),
    ],
  );
}
}