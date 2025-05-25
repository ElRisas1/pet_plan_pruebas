import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:pet_plan_pruebas/pantalla_info_usu.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:pet_plan_pruebas/pantalla_edit_perfilUsu.dart';
import 'package:pet_plan_pruebas/pantalla_mascota.dart';
import 'package:pet_plan_pruebas/pantalla_agregar_mascota.dart';
import 'package:pet_plan_pruebas/pantalla_login.dart';

class PantallaPerfil extends StatefulWidget {
  const PantallaPerfil({super.key});

  @override
  State<PantallaPerfil> createState() => _PantallaPerfilState();
}

class _PantallaPerfilState extends State<PantallaPerfil> {
  List<Map<String, dynamic>> mascotas = [];
  bool cargando = true;
  String? _fotoUrl;

  @override
  void initState() {
    super.initState();
    _cargarMascotas();
    _cargarFotoUsuario();
  }

  Future<void> _cargarMascotas() async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) {
      setState(() => cargando = false);
      return;
    }

    final data = await Supabase.instance.client
        .from('mascota')
        .select()
        .eq('id_usuario', user.id);

    setState(() {
      mascotas = List<Map<String, dynamic>>.from(data);
      cargando = false;
    });
  }

  Future<void> _cargarFotoUsuario() async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) return;

    final data = await Supabase.instance.client
        .from('Usuarios')
        .select('Foto')
        .eq('user_id', user.id)
        .single();

    setState(() {
      _fotoUrl = data['Foto'];
    });
  }

  void _cerrarSesion(BuildContext context) async {
    await Supabase.instance.client.auth.signOut();

    if (!context.mounted) return;

    Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color.fromARGB(248, 152, 184, 239),
      appBar: AppBar(title: const Text("nombre del usuario")),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 50),
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(shape: BoxShape.circle),
                    child: CircleAvatar(
                      radius: 70,
                      backgroundImage: _fotoUrl != null && _fotoUrl!.isNotEmpty
                          ? NetworkImage(_fotoUrl!)
                          : const AssetImage('assets/profile_pic.png') as ImageProvider,
                      backgroundColor: Colors.grey[200],
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text('@perfilprueba1', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const Text('Pedro', style: TextStyle(fontSize: 20)),
                  const SizedBox(height: 20),
                  Center(
                    child: FractionallySizedBox(
                      widthFactor: 0.8,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        color: Colors.white,
                        elevation: 6,
                        child: const Padding(
                          padding: EdgeInsets.all(16),
                          child: Text(
                            'Prueba de texto',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      elevation: 6,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PantallaInfoUsu(title: '')),
                      );
                    },
                    child: const Text('Más Información'),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        const Text('Tus mascotas', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 10),
                        cargando
                            ? const CircularProgressIndicator()
                            : CarouselSlider(
                                items: [
                                  ...mascotas.map((mascota) {
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => PantallaMascota(
                                              nombreMascota: mascota['Nombre'] ?? 'Sin nombre',
                                              imagenMascota: mascota['Foto'] ?? '',
                                              edad: mascota['Edad'] ?? 0,
                                              raza: mascota['Raza'] ?? 'Desconocida',
                                              peso: (mascota['Peso'] != null)
                                                  ? double.tryParse(mascota['Peso'].toString()) ?? 0.0
                                                  : 0.0,
                                            ),
                                          ),
                                        );
                                      },
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
                                    );
                                  }),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => PantallaAgregarMascota()),
                                      );
                                    },
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        CircleAvatar(
                                          radius: 40,
                                          backgroundColor: Colors.blue[100],
                                          child: const Icon(Icons.add, color: Colors.green, size: 30),
                                        ),
                                        const SizedBox(height: 10),
                                        const Text('Añadir mascota', style: TextStyle(fontSize: 16)),
                                      ],
                                    ),
                                  ),
                                ],
                                options: CarouselOptions(
                                  height: 150,
                                  enlargeCenterPage: true,
                                  enableInfiniteScroll: false,
                                ),
                              ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      elevation: 6,
                    ),
                    onPressed: () => _cerrarSesion(context),
                    child: const Text('Cerrar sesión'),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            Positioned(
              top: screenHeight * 0.05,
              right: screenWidth * 0.05,
              child: const EditarPerfil(),
            ),
          ],
        ),
      ),
    );
  }
}

class EditarPerfil extends StatelessWidget {
  const EditarPerfil({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      shape: const CircleBorder(),
      elevation: 5,
      child: IconButton(
        icon: const Icon(Icons.edit, size: 40, color: Colors.blueGrey),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const PantallaEditPerfilUsu(title: ''),
            ),
          );
        },
      ),
    );
  }
}
