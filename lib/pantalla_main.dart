import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
// pantallas
import 'package:pet_plan_pruebas/pantalla_ajustes.dart';
import 'package:pet_plan_pruebas/pantalla_ayuda.dart';
import 'package:pet_plan_pruebas/pantalla_chatia.dart';
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

   //Lista de mascotas para el carrusel
  final List<String> mascotas = ["Firulais", "Luna", "Max"];

  final String nombrePrueba = "chamaquito"; //nombre de prueba para el usuario

  //lista de recordatorios de prueba
  List<String> recordatorios = ["saca a firulais a pasear", "Dale la pastilla a Luna", "Hoy le toca veterinario a Max" ];

  //lista de items para el dropdown menu
  List<String> menu = ["Menu","Ajustes", "Ayuda"];

  String? selectedItem = "Menu";  //item seleccionado, empieza siendo 'menu'

  
  /// Void para gestionar las selecciones
  void onMenuSelected(String? item) {
      if (item == null) return; // si es null

      setState(() => selectedItem = item); // actualiza el estado con el ítem seleccionado

      if (item == "Ajustes") {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PantallaAjustes(title: '',)),
        );
      } else if (item == "Ayuda") {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PantallaAyuda(title: '',)),
        );
      }
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(248, 238, 220, 138),
      body: content(),
    );
  }

  // MAPA DE MASCOTAS E IMAGENES //
  Map<String, String> imagenesMascotas = {
    "Firulais": "assets/Perro1.png",
    "Luna": "assets/gatobonito.jpg",
    "Max": "assets/GatoEgipcio.png",
  };


  Widget content() {
  return Stack(
    children: [
      // AppBar
      AppBar(
        title: Text("Pet Plan"),
        backgroundColor: Color.fromARGB(100, 255, 242, 168),
      ),

      // DROP DOWN MENU //
      Positioned(
            top: 50,
            left: 15,
            child: DropdownButton<String>(
              value: selectedItem, // Puede ser nulo, o sea no hay nada seleccionado.
              hint: Text("Selecciona"), // Texto cuando no hay selección
              items: menu.map((item) => DropdownMenuItem<String>(
                value: item,
                child: Text(item, style: TextStyle(fontSize: 15)),
              )).toList(),
              onChanged: onMenuSelected,
            ),
          ),
    
      // IMAGEN DE PERFIL - Ubicación en la parte superior derecha
      Positioned(
        top: 50, 
        right: 15, 
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
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PantallaPerfil(),
                  ),
                );
              },
              child: ClipOval( // Hace la imagen redonda
                child: Image.asset(
                  'assets/profile_pic.png', 
                  width: 80, 
                  height: 80,
                  fit: BoxFit.cover, // Ajusta la imagen al círculo
                ),
              ),
            ),
          ),
        ),
      ),
          
          // TITULO MIS MASCOTAS //
          Padding(
            padding: const EdgeInsets.only(top: 160, left: 98 ), // Ajusta el espacio superior para evitar que se solape con el AppBar
            child: const Text(
              "Mis Mascotas", 
              style: TextStyle(
                fontSize: 35,
                color: Color.fromARGB(218, 0, 0, 0),
                fontWeight: FontWeight.bold, // Puedes cambiar el peso para que se vea más destacado
              ),
            ),
          ),
          
          // CONTENEDOR CON EL CARRUSEL DE MASCOTAS //
          Container(
            margin: const EdgeInsets.only(left: 15, top: 230, bottom: 20),
            child: CarouselSlider(
              items: mascotas.map((mascota) {
                return GestureDetector( //esto detecta que item se presiona y asi nos manda a su pantalla correspondiente
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PantallaMascota(
                          nombreMascota: mascota, 
                          imagenMascota: imagenesMascotas[mascota] ?? 'assets/default.png', // Imagen por defecto si no hay una asignada
                          recordatorios: [
                            "Saca a $mascota a pasear",
                            "Dale la pastilla a $mascota",
                            "Le toca veterinario a $mascota"
                          ],),
                      ),
                    );
                  },

                  // ITEMS DEL CARRUSEL // 
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 7),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 152, 184, 239),
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
                height: 160,
                enlargeCenterPage: true,
              ),
            ),
          ),

          // TITULO RECORDATORIOS //
          Padding(
            padding: const EdgeInsets.only(top: 450, left: 115 ), // Ajusta el espacio superior para evitar que se solape con el AppBar
            child: const Text(
              "Recordatorios", 
              style: TextStyle(
                fontSize: 28,
                color: Color.fromARGB(218, 0, 0, 0),
                fontWeight: FontWeight.bold, // Puedes cambiar el peso para que se vea más destacado
              ),
            ),
          ),  

          // LISTA DE RECORDATORIOS //
          Positioned(
            top: 515, left: 49, right: 49,
            child: Container(
              height: 200,
              width: 300,
              decoration: BoxDecoration(
                color: Colors.white, //fondo blanco de la lista
                borderRadius: BorderRadius.circular(10), //bordes redondeados
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0, 2),
                  )
                ]
              ),
              child: ListView.builder(
              itemCount: recordatorios.length,
              itemBuilder:(context, index) {
                return ListTile(
                  title: Text(recordatorios[index]),
                );
              },),
            ),
          ),

          // BOTON CHAT IA //
          Positioned(
            top: 780, left: 100, right: 100,
            //boton
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PantallaChatIA(title: "pantalla ia")),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent, // Color del botón
                foregroundColor: Colors.white, // Color del texto
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // Bordes redondeados
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 45, 
                  vertical: 20), // Tamaño del botón
                elevation: 8, // Sombra para el botón
              ),
              child: const Text(
                "Hablar con IA",
                style: TextStyle(
                  fontSize: 20, 
                  fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],//Children
    );
  }
}