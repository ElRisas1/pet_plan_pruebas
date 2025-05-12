import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
          MaterialPageRoute(builder: (context) => PantallaAyuda(title: '', opcionesAjustes: '',)),
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

  @override
  void initState() {
    super.initState();
    _cargarRecordatorios();
  }

  Future<void> _cargarRecordatorios() async {
    try {
      final supabase = Supabase.instance.client;
      final data = await supabase.from('recordatorios').select().order('Fecha');
      setState(() {
        recordatorios = List<Map<String, dynamic>>.from(data);
        cargandoRecordatorios = false;
      });
    } catch (e) {
      print("Error cargando recordatorios: $e");
      setState(() {
        cargandoRecordatorios = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color.fromARGB(248, 238, 220, 138),
      body: Stack(
        children: [
          AppBar(
            title: const Text("Pet Plan"),
            backgroundColor: Color.fromARGB(100, 255, 242, 168),
          ),

          // Botón circular de ajustes
          Positioned(
            top: screenHeight * 0.06,
            left: screenWidth * 0.05,
            child: Material(
              color: Colors.white,
              shape: const CircleBorder(),
              elevation: 5,
              child: IconButton(
                icon: const Icon(Icons.settings, size: 30, color: Colors.blueGrey),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PantallaAjustes(title: '')),
                  );
                },
              ),
            ),
          ),

          // Botón de perfil
          Positioned(
            top: screenHeight * 0.06,
            right: screenWidth * 0.05,
            child: Material(
              elevation: 8,
              shape: const CircleBorder(),
              clipBehavior: Clip.antiAlias,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2.5),
                ),
                child: InkWell(
                  splashColor: Colors.black26,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PantallaPerfil()),
                    );
                  },
                  child: ClipOval(
                    child: Image.asset(
                      'assets/profile_pic.png',
                      width: screenWidth * 0.2,
                      height: screenWidth * 0.2,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Título "Mis Mascotas"
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.2),
              child: const Text(
                "Mis Mascotas",
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
              ),
            ),
          ),

          // Carrusel de mascotas
          Positioned(
            top: screenHeight * 0.28,
            left: screenWidth * 0.05,
            right: screenWidth * 0.05,
            child: CarouselSlider(
              items: mascotas.map((mascota) {
                return GestureDetector(
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

          // Título "Recordatorios"
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.55),
              child: const Text(
                "Recordatorios",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
            ),
          ),

          // Caja de recordatorios
          Positioned(
            top: screenHeight * 0.62,
            left: screenWidth * 0.1,
            right: screenWidth * 0.1,
            child: Container(
              height: screenHeight * 0.25,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(color: Colors.black26, offset: Offset(0, 2)),
                ],
              ),
              child: cargandoRecordatorios
                  ? const Center(child: CircularProgressIndicator())
                  : recordatorios.isEmpty
                      ? const Center(child: Text("No hay recordatorios"))
                      : ListView.separated(
                          itemCount: recordatorios.length,
                          separatorBuilder: (context, index) => const Divider(),
                          itemBuilder: (context, index) {
                            final rec = recordatorios[index];
                            final fecha = DateTime.tryParse(rec['Fecha'] ?? '') ?? DateTime.now();

                            return ListTile(
                              leading: const Icon(Icons.alarm, color: Colors.blueAccent),
                              title: Text(rec['Nombre'] ?? 'Sin nombre'),
                              subtitle: Text(
                                "🐾 ${rec['Notas'] ?? ''}\n📅 ${DateFormat('dd/MM/yyyy – HH:mm').format(fecha)}",
                                style: const TextStyle(fontSize: 12),
                              ),
                              trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetalleRecordatorio(
                                      nombre: rec['Nombre'],
                                      fecha: DateFormat('dd/MM/yyyy').format(fecha),
                                      hora: DateFormat('HH:mm').format(fecha),
                                      nota: rec['Notas'],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
            ),
          ),

          // Botón "+" para agregar recordatorio
          Positioned(
            top: screenHeight * 0.595,
            right: screenWidth * 0.08,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                MaterialPageRoute(builder: (context) => const PantallaRecordatorio(recordatorio: "")),
                );
              },
              backgroundColor: Colors.green,
              child: const Icon(Icons.add),
              mini: true,
              heroTag: "btnAddRecordatorio",
            ),
          ),

          // Botón para hablar con IA
          Positioned(
            bottom: screenHeight * 0.05,
            left: screenWidth * 0.2,
            right: screenWidth * 0.2,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PantallaChatIA(title: "pantalla ia")),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                elevation: 8,
              ),
              child: const Text(
                "Hablar con IA",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}