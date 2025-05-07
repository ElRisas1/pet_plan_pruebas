import 'package:flutter/material.dart';
import 'package:pet_plan_pruebas/pantalla_ayuda.dart';
import 'package:pet_plan_pruebas/pantalla_chatia.dart';
import 'package:pet_plan_pruebas/pantalla_main.dart';
import 'package:pet_plan_pruebas/pantalla_perfil.dart';
// Suponemos que las siguientes pantallas existen:
//import 'package:pet_plan_pruebas/pantalla_privacidad.dart';
//import 'package:pet_plan_pruebas/pantalla_logout.dart';

class PantallaAjustes extends StatefulWidget {
  const PantallaAjustes({super.key, required this.title});

  final String title;

  @override
  _PantallaAjustesState createState() => _PantallaAjustesState();
}

class _PantallaAjustesState extends State<PantallaAjustes> {

  // Variables //

  // Listas //

  //Opciones de la lista principal.
  final List<_AjusteItem> opcionesAjustes = [
    _AjusteItem(
      nombre: "Ayuda",
      destino: PantallaAyuda(title: "Ayuda", opcionesAjustes: "Ayuda"),
    ),
    _AjusteItem(
      nombre: "Política de privacidad",
      destino: PantallaPerfil(),
    ),
    _AjusteItem(
      nombre: "Cerrar sesión",
      destino: PantallaPerfil(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color.fromARGB(248, 152, 184, 239),
      appBar: AppBar(title: const Text("PetPlan")),
      body: SingleChildScrollView(
        child: SizedBox(
          height: screenHeight * 1.5,
          child: Stack(
            children: [
              // Título
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.only(top: screenHeight * 0.03),
                  child: const Text(
                    "Ajustes",
                    style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              // Lista de opciones
              Positioned(
                top: screenHeight * 0.13,
                left: screenWidth * 0.1,
                right: screenWidth * 0.1,
                child: Container(
                  height: screenHeight * 0.25,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0, 2),
                      )
                    ],
                  ),
                  child: ListView.separated(
                    itemCount: opcionesAjustes.length,
                    separatorBuilder: (context, index) => const Divider(),
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: const Icon(Icons.settings, color: Colors.blueGrey),
                        title: Text(
                          opcionesAjustes[index].nombre,
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 18, color: Colors.grey),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => opcionesAjustes[index].destino,
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


// Clase auxiliar para las opciones
class _AjusteItem {
  final String nombre;
  final Widget destino;

  _AjusteItem({required this.nombre, required this.destino});
}

