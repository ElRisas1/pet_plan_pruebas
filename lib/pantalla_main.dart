import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
// Pantallas
import 'package:pet_plan_pruebas/pantalla_ajustes.dart';
import 'package:pet_plan_pruebas/pantalla_ayuda.dart';
import 'package:pet_plan_pruebas/pantalla_chatia.dart';
import 'package:pet_plan_pruebas/pantalla_mascota.dart';
import 'package:pet_plan_pruebas/pantalla_perfil.dart';
import 'package:pet_plan_pruebas/pantalla_recordatorio.dart';



class PantallaPrincipal extends StatefulWidget {
  const PantallaPrincipal({super.key, required this.title});

  final String title;

  @override
  State<PantallaPrincipal> createState() => _PantallaPrincipalState();
}


class _PantallaPrincipalState extends State<PantallaPrincipal> {

  // VARIABLES
  String? selectedItem = "Menu";  //item seleccionado, empieza siendo 'menu'
  final String nombrePrueba = "chamaquito (Y esta vaina? JJAJAJAJ, vaya nombres os sacais guapos)"; //nombre de prueba para el usuario

  // Listas //
  final List<String> mascotas = ["Firulais", "Luna", "Max"]; //Lista de mascotas para el carrusel

  List<String> recordatorios = ["saca a firulais a pasear", "Dale la pastilla a Luna", "Hoy le toca veterinario a Max" ];  //lista de recordatorios de prueba

  List<String> menu = ["Menu","Ajustes", "Ayuda"]; //lista de items para el dropdown menu

  
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
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

  return Stack(
    children: [
      // AppBar
      AppBar(
        title: Text("Pet Plan"),
        backgroundColor: Color.fromARGB(100, 255, 242, 168),
      ),

      // DROP DOWN MENU //
      Positioned(
            top: screenHeight * 0.06,
            left: screenWidth * 0.05,
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
        top: screenHeight * 0.06,
        right: screenWidth * 0.05, 
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
                  width: screenWidth * 0.2,
                  height: screenWidth * 0.2,
                  fit: BoxFit.cover, // Ajusta la imagen al círculo
                ),
              ),
            ),
          ),
        ),
      ),
          
          // TITULO MIS MASCOTAS //
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.2),
              child: const Text(
                "Mis Mascotas",
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          
          // CONTENEDOR CON EL CARRUSEL DE MASCOTAS //
          Positioned(
            top: screenHeight * 0.28,
            left: screenWidth * 0.05,
            right: screenWidth * 0.05,
            child: CarouselSlider(
              items: mascotas.map((mascota) {
                return GestureDetector( //esto detecta que item se presiona y asi nos manda a su pantalla correspondiente
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PantallaMascota(
                          nombreMascota: mascota,
                          imagenMascota: imagenesMascotas[mascota] ?? 'assets/default.png',
                        ),
                      ),
                    );
                  },

                  // ITEMS DEL CARRUSEL // 
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
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
                height: screenHeight * 0.22,
                enlargeCenterPage: true,
              ),
            ),
          ),

          // TITULO RECORDATORIOS //
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.55),
              child: const Text(
                "Recordatorios",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          // LISTA DE RECORDATORIOS //
          Positioned(
            top: screenHeight * 0.62,
            left: screenWidth * 0.1,
            right: screenWidth * 0.1,
            child: Container(
              height: screenHeight * 0.25,
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
              child: ListView.separated(
              itemCount: recordatorios.length,
              separatorBuilder: (context, index) => Divider(),
              itemBuilder:(context, index) {
                return ListTile(
                  leading: Icon(Icons.alarm, color: Colors.blueAccent), // Ícono de alarma
                  title: Text(recordatorios[index],
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios, size: 18, color:Colors.grey),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PantallaRecordatorio(recordatorio: recordatorios[index])
                      )
                    );
                  },
                );
              },),
            ),
          ),

          // BOTON CHAT IA //
          Positioned(
            bottom: screenHeight * 0.05,
            left: screenWidth * 0.2,
            right: screenWidth * 0.2,
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
                padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02), // Tamaño del botón
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