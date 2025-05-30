import 'package:flutter/material.dart';
import 'package:pet_plan_pruebas/pantallaQR.dart';
import 'package:pet_plan_pruebas/pantalla_editar_mascota.dart';
import 'package:pet_plan_pruebas/pantalla_recordatorio.dart';
import 'package:pet_plan_pruebas/pantalla_nuevoRecordatorio.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PantallaMascota extends StatefulWidget {
  final String nombreMascota;
  final String imagenMascota;
  final int edad;
  final String raza;
  final double peso;

  const PantallaMascota({
    super.key,
    required this.nombreMascota,
    required this.imagenMascota,
    required this.edad,
    required this.raza,
    required this.peso,
  });

  @override
  State<PantallaMascota> createState() => _PantallaMascotaState();
}

class _PantallaMascotaState extends State<PantallaMascota> {
  String imagenActual = '';
  List<String> recordatorios = [
    "Saca a Firulais a pasear",
    "Dale la pastilla a Luna",
    "Hoy le toca veterinario a Max",
  ];

  @override
  void initState() {
    super.initState();
    _cargarImagenActual();
  }

  Future<void> _cargarImagenActual() async {
    final supabase = Supabase.instance.client;
    final data = await supabase
        .from('mascota')
        .select('Foto')
        .eq('Nombre', widget.nombreMascota)
        .maybeSingle();

    if (data != null && data['Foto'] != null) {
      setState(() {
        imagenActual = data['Foto'];
      });
    } else {
      setState(() {
        imagenActual = '';
      });
    }
  }

  Future<void> _abrirEditor() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PantallaEditarMascota(
          title: 'Editar Mascota',
          nombreMascota: widget.nombreMascota,
        ),
      ),
    );
    await _cargarImagenActual(); // refrescar imagen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.nombreMascota),
        backgroundColor: const Color.fromARGB(248, 144, 177, 235),
      ),
      body: Container(
        color: const Color.fromARGB(248, 144, 177, 235),
        width: double.infinity,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _titulo(widget.nombreMascota),
                  _editarPerfil(),
                ],
              ),
              const SizedBox(height: 20),
              _imagenPerfil(imagenActual),
              const SizedBox(height: 30),
              _infoMascota(widget.nombreMascota, widget.edad, widget.raza, widget.peso),
              const SizedBox(height: 20),
              _botonQR(),
              const SizedBox(height: 30),
              _tituloSeccion("Recordatorios"),
              const SizedBox(height: 10),
              _listaRecordatorios(),
              const SizedBox(height: 20),
              _botonNuevoRecordatorio(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _titulo(String nombre) {
    return Text(nombre, style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold));
  }

  Widget _imagenPerfil(String imagen) {
    final bool esUrlValida = imagen.isNotEmpty && imagen.startsWith('http');
    return Material(
      elevation: 8,
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 2.5),
        ),
        child: CircleAvatar(
          radius: 50,
          backgroundImage: esUrlValida ? NetworkImage(imagen) : null,
          child: !esUrlValida
              ? const Icon(Icons.pets, size: 40, color: Colors.grey)
              : null,
          backgroundColor: Colors.grey[200],
        ),
      ),
    );
  }

  Widget _editarPerfil() {
    return Material(
      color: Colors.white,
      shape: const CircleBorder(),
      elevation: 5,
      child: IconButton(
        icon: const Icon(Icons.edit, size: 40, color: Colors.blueGrey),
        onPressed: _abrirEditor,
      ),
    );
  }

  Widget _infoMascota(String nombre, int edad, String raza, double peso) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 6)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Nombre: $nombre", style: const TextStyle(fontSize: 18)),
          Text("Edad: $edad años", style: const TextStyle(fontSize: 18)),
          Text("Raza: $raza", style: const TextStyle(fontSize: 18)),
          Text("Peso: ${peso.toStringAsFixed(1)} kg", style: const TextStyle(fontSize: 18)),
        ],
      ),
    );
  }

  Widget _botonQR() {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const PantallaQR(idMascota: 'abc123')),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 255, 161, 79),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 8,
      ),
      child: const Text("QR", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
    );
  }

  Widget _tituloSeccion(String titulo) {
    return Text(titulo, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold));
  }

  Widget _listaRecordatorios() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [BoxShadow(color: Colors.black26, offset: Offset(0, 2))],
      ),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: recordatorios.length,
        separatorBuilder: (_, __) => const Divider(),
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(Icons.alarm, color: Colors.blueAccent),
            title: Text(recordatorios[index], style: const TextStyle(fontSize: 16)),
            trailing: const Icon(Icons.arrow_forward_ios, size: 18),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PantallaRecordatorio(recordatorio: recordatorios[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _botonNuevoRecordatorio() {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const PantallaNuevoRecordatorio(title: 'Nuevo Recordatorio')),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 255, 161, 79),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 8,
      ),
      child: const Text("Nuevo Recordatorio", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
    );
  }
}

