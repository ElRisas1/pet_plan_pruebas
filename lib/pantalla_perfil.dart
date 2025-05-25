import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:pet_plan_pruebas/pantalla_info_usu.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:pet_plan_pruebas/pantalla_edit_perfilUsu.dart';
import 'package:pet_plan_pruebas/pantalla_mascota.dart';
import 'package:pet_plan_pruebas/pantalla_agregar_mascota.dart';
import 'package:pet_plan_pruebas/pantalla_login.dart';
import 'package:intl/intl.dart';

class PantallaPerfil extends StatefulWidget {
  const PantallaPerfil({super.key});

  @override
  State<PantallaPerfil> createState() => _PantallaPerfilState();
}

class _PantallaPerfilState extends State<PantallaPerfil> {
  List<Map<String, dynamic>> mascotas = [];
  bool cargando = true;
  bool cargandoUsuario = true;

  String? _fotoUrl;
  String? _nombreUsuario;
  String? _username;
  String? _email;

  @override
  void initState() {
    super.initState();
    _cargarTodo();
  }

  Future<void> _cargarTodo() async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) return;

    final dataUsuario = await Supabase.instance.client
        .from('Usuarios')
        .select()
        .eq('user_id', user.id)
        .maybeSingle();

    final dataMascotas = await Supabase.instance.client
        .from('mascota')
        .select()
        .eq('id_usuario', user.id);

    setState(() {
      _fotoUrl = dataUsuario?['Foto'];
      _nombreUsuario = dataUsuario?['Nombre'];
      _username = dataUsuario?['Username'];
      _email = user.email;
      mascotas = List<Map<String, dynamic>>.from(dataMascotas);
      cargando = false;
      cargandoUsuario = false;
    });
  }

  void _cerrarSesion() async {
    await Supabase.instance.client.auth.signOut();
    if (!mounted) return;
    Navigator.of(context).pushNamedAndRemoveUntil('/login', (_) => false);
  }

  int _calcularEdadDesdeFecha(String? fechaStr) {
    if (fechaStr == null || fechaStr.isEmpty) return 0;
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
      backgroundColor: const Color.fromARGB(248, 152, 184, 239),
      appBar: AppBar(title: Text(_nombreUsuario ?? 'Perfil')),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 50),
                  CircleAvatar(
                    radius: 70,
                    backgroundImage: _fotoUrl != null && _fotoUrl!.isNotEmpty
                        ? NetworkImage(_fotoUrl!)
                        : const AssetImage('assets/profile_pic.png') as ImageProvider,
                    backgroundColor: Colors.grey[200],
                  ),
                  const SizedBox(height: 10),
                  Text('@${_username ?? "usuario"}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Text(_nombreUsuario ?? '', style: const TextStyle(fontSize: 20)),
                  Text(_email ?? '', style: const TextStyle(fontSize: 16)),
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
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: cargandoUsuario
                              ? const CircularProgressIndicator()
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Nombre: ${_nombreUsuario ?? "N/D"}'),
                                    const SizedBox(height: 8),
                                    Text('Username: @${_username ?? "N/D"}'),
                                    const SizedBox(height: 8),
                                    Text('Email: ${_email ?? "N/D"}'),
                                  ],
                                ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.green, elevation: 6),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const PantallaInfoUsu(title: ''),
                        ),
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
                      boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 8)],
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
                                    final edad = _calcularEdadDesdeFecha(mascota['Edad']);
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
                                            backgroundImage: (mascota['Foto'] != null && mascota['Foto'].toString().isNotEmpty)
                                                ? NetworkImage(mascota['Foto'])
                                                : null,
                                            child: (mascota['Foto'] == null || mascota['Foto'].toString().isEmpty)
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
                                    onTap: () async {
                                      await Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (_) => const PantallaAgregarMascota()),
                                      );
                                      await _cargarTodo();
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
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red, elevation: 6),
                    onPressed: () => _cerrarSesion(),
                    child: const Text('Cerrar sesión'),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            Positioned(
              top: screenHeight * 0.05,
              right: screenWidth * 0.05,
              child: Material(
                color: Colors.white,
                shape: const CircleBorder(),
                elevation: 5,
                child: IconButton(
                  icon: const Icon(Icons.edit, size: 40, color: Colors.blueGrey),
                  onPressed: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const PantallaEditPerfilUsu(title: '')),
                    );
                    await _cargarTodo(); // refresca después de editar
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
