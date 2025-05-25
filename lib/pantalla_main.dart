import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'pantalla_recordatorio.dart';
import 'pantalla_ajustes.dart';
import 'pantalla_chatia.dart';
import 'pantalla_mascota.dart';
import 'pantalla_perfil.dart';
import "detallerecordatorio.dart";

class PantallaPrincipal extends StatefulWidget {
  const PantallaPrincipal({super.key, required this.title});
  final String title;

  @override
  State<PantallaPrincipal> createState() => _PantallaPrincipalState();
}

class _PantallaPrincipalState extends State<PantallaPrincipal> {
  List<Map<String, dynamic>> mascotas = [];
  List<Map<String, dynamic>> recordatorios = [];
  bool cargandoRecordatorios = true;
  bool cargandoMascotas = true;
  String? _fotoPerfil;

  @override
  void initState() {
    super.initState();
    _cargarRecordatorios();
    _cargarMascotas();
    _cargarFotoPerfil();
  }

  Future<void> _cargarFotoPerfil() async {
    try {
      final user = Supabase.instance.client.auth.currentUser;
      if (user == null) return;

      final data = await Supabase.instance.client
          .from('Usuarios')
          .select('Foto')
          .eq('user_id', user.id)
          .maybeSingle();

      if (!mounted) return;

      setState(() {
        _fotoPerfil = data?['Foto'];
      });
    } catch (e) {
      print("Error cargando foto de perfil: $e");
    }
  }

  Future<void> _cargarMascotas() async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) {
      if (!mounted) return;
      setState(() => cargandoMascotas = false);
      return;
    }

    try {
      final data = await Supabase.instance.client
          .from('mascota')
          .select()
          .eq('id_usuario', user.id);

      if (!mounted) return;
      setState(() {
        mascotas = List<Map<String, dynamic>>.from(data);
        cargandoMascotas = false;
      });
    } catch (e) {
      print("Error cargando mascotas: $e");
      if (!mounted) return;
      setState(() => cargandoMascotas = false);
    }
  }

  Future<void> _cargarRecordatorios() async {
    try {
      final supabase = Supabase.instance.client;
      final data = await supabase.from('recordatorios').select().order('Fecha');

      if (!mounted) return;
      setState(() {
        recordatorios = List<Map<String, dynamic>>.from(data);
        cargandoRecordatorios = false;
      });
    } catch (e) {
      print("Error cargando recordatorios: $e");
      if (!mounted) return;
      setState(() {
        cargandoRecordatorios = false;
      });
    }
  }

  int calcularEdadDesdeFecha(String fechaStr) {
    try {
      final fecha = DateFormat('dd/MM/yyyy').parse(fechaStr);
      final hoy = DateTime.now();
      int edad = hoy.year - fecha.year;
      if (hoy.month < fecha.month || (hoy.month == fecha.month && hoy.day < fecha.day)) {
        edad--;
      }
      return edad;
    } catch (_) {
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Pet Plan"),
        backgroundColor: const Color.fromARGB(100, 255, 242, 168),
      ),
      backgroundColor: const Color.fromARGB(248, 238, 220, 138),
      body: Stack(
        children: [
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
                    MaterialPageRoute(builder: (context) => const PantallaAjustes(title: '')),
                  );
                },
              ),
            ),
          ),
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
                      MaterialPageRoute(builder: (context) => const PantallaPerfil()),
                    );
                  },
                  child: ClipOval(
                    child: _fotoPerfil != null && _fotoPerfil!.isNotEmpty
                        ? Image.network(
                            _fotoPerfil!,
                            width: screenWidth * 0.2,
                            height: screenWidth * 0.2,
                            fit: BoxFit.cover,
                          )
                        : Image.asset(
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
          Positioned(
            top: screenHeight * 0.28,
            left: screenWidth * 0.05,
            right: screenWidth * 0.05,
            child: cargandoMascotas
                ? const Center(child: CircularProgressIndicator())
                : CarouselSlider(
                    items: mascotas.map((mascota) {
                      final edad = calcularEdadDesdeFecha(mascota['Edad'].toString());
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PantallaMascota(
                                nombreMascota: mascota['Nombre'] ?? 'Sin nombre',
                                imagenMascota: mascota['Foto'] ?? '',
                                edad: edad,
                                raza: mascota['Raza'] ?? 'Desconocida',
                                peso: double.tryParse(mascota['Peso'].toString()) ?? 0.0,
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
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 40,
                                  backgroundImage: (mascota['Foto'] != null &&
                                          mascota['Foto'].toString().isNotEmpty)
                                      ? NetworkImage(mascota['Foto'])
                                      : null,
                                  child: (mascota['Foto'] == null ||
                                          mascota['Foto'].toString().isEmpty)
                                      ? const Icon(Icons.pets, size: 30, color: Colors.grey)
                                      : null,
                                  backgroundColor: Colors.grey[200],
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  mascota['Nombre'] ?? 'Sin nombre',
                                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                                ),
                              ],
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
          Positioned(
            top: screenHeight * 0.53,
            left: screenWidth * 0.1,
            right: screenWidth * 0.1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Recordatorios",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                Material(
                  color: Colors.green,
                  shape: const CircleBorder(),
                  child: IconButton(
                    icon: const Icon(Icons.add, size: 28, color: Colors.white),
                    onPressed: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PantallaRecordatorio(recordatorio: ""),
                        ),
                      );
                      _cargarRecordatorios();
                    },
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: screenHeight * 0.6,
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
                                      id: rec['Id_recor'],
                                      nombre: rec['Nombre'],
                                      fecha: DateFormat('dd/MM/yyyy').format(fecha),
                                      hora: DateFormat('HH:mm').format(fecha),
                                      nota: rec['Notas'] ?? '',
                                    ),
                                  ),
                                ).then((eliminado) {
                                  if (eliminado == true) {
                                    _cargarRecordatorios();
                                  }
                                });
                              },
                            );
                          },
                        ),
            ),
          ),
          Positioned(
            bottom: screenHeight * 0.05,
            left: screenWidth * 0.2,
            right: screenWidth * 0.2,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PantallaChatIA(title: "pantalla ia")),
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
