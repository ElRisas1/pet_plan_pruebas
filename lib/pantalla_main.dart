import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:pet_plan_pruebas/pantalla_mascota.dart';
import 'package:pet_plan_pruebas/pantalla_perfil.dart';



class PantallaPrincipal extends StatefulWidget {
  const PantallaPrincipal({super.key, required this.title});

  final String title;

  @override
  State<PantallaPrincipal> createState() => _PantallaPrincipalState();
}


class _PantallaPrincipalState extends State<PantallaPrincipal> {

  //VARIABLES

  final List<String> mascotas = ["Firulais", "Luna", "Max"];
  final String nombrePrueba = "chamaquito";


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
        AppBar(title: Text("Pet Plan"), 
          backgroundColor: Color.fromARGB(100, 255, 242, 168),
        ),
        const Divider(height: 90),
          // IMAGEN DE PERFIL//
          Positioned(
            top: 40, 
            right: 20, 
            child: Material(
              elevation: 8, //esto agrega sombra al botón
              shape: const CircleBorder(), // mantiene la forma circular
              clipBehavior: Clip.antiAlias, // suaviza los bordes del círculo
              child: Container(
                padding: const EdgeInsets.all(4), // Espaciado para el borde
                decoration: BoxDecoration(
                  shape: BoxShape.circle, // Hace que el borde sea redondo
                  border: Border.all(color: Colors.white, width: 2.5), // borde blanco
                ),
                child: InkWell(
                  splashColor: Colors.black26, // efecto al tocar
                  onTap: () {
                    Navigator.push(context,
                      MaterialPageRoute(
                        builder: (context) => PantallaPerfil(nombreUser: '', title: ''),
                      ),
                    );
                  },
                  child: ClipOval( // Hace la imagen redonda
                    child: Image.asset('assets/logolorena.png', 
                      width: 80, 
                      height: 80,
                      fit: BoxFit.cover, // Ajusta la imagen al círculo
                    ),
                  ),
                ),
              )
            ),
          ),

          // CONTENEDOR CON EL CARRUSEL DE MASCOTAS//
          Container(
            margin: const EdgeInsets.only(left: 15, top: 350, bottom: 20),
            child: CarouselSlider(
              items: mascotas.map((mascota) {
                return GestureDetector( //esto detecta que item se presiona y asi nos manda a su pantalla correspondiente
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PantallaMascota(nombreMascota: mascota, title: ''),
                      ),
                    );
                  },
                  // ITEMS DEL CARRUSEL// 
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 7),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 238, 239, 232),
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
      ],//Children
    );
  }
}