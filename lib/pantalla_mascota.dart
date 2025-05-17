import 'package:flutter/material.dart';
//Pantallas
import 'package:pet_plan_pruebas/pantallaQR.dart';
import 'package:pet_plan_pruebas/pantalla_recordatorio.dart';
import 'package:pet_plan_pruebas/pantalla_nuevoRecordatorio.dart';

class PantallaMascota extends StatelessWidget {
  final String nombreMascota;
  final String imagenMascota;
  final List<String> recordatorios;

  PantallaMascota({
    super.key,
    required this.nombreMascota,
    required this.imagenMascota,
  }) : recordatorios = [
    "Saca a Firulais a pasear",
    "Dale la pastilla a Luna",
    "Hoy le toca veterinario a Max"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(nombreMascota),
        backgroundColor: const Color.fromARGB(248, 144, 177, 235),
      ),
      body: Container(
        color: const Color.fromARGB(248, 144, 177, 235),
        width: double.infinity,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Container(
            // Este Container asegura que la altura mínima ocupe toda la pantalla
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height - kToolbarHeight - MediaQuery.of(context).padding.top,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _titulo(nombreMascota),
                const SizedBox(height: 20),
                _imagenPerfil(imagenMascota),
                const SizedBox(height: 30),
                _infoMascota(nombreMascota),
                const SizedBox(height: 20),
                _botonQR(context),
                const SizedBox(height: 30),
                _tituloSeccion("Recordatorios"),
                const SizedBox(height: 10),
                _listaRecordatorios(context, recordatorios),
                const SizedBox(height: 20),
                _botonNuevoRecordatorio(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _titulo(String nombre) {
    return Text(
      nombre,
      style: const TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }

  Widget _imagenPerfil(String imagen) {
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
          backgroundImage: AssetImage(imagen),
        ),
      ),
    );
  }

  Widget _infoMascota(String nombre) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 6,
            offset: Offset(0, 3),
          )
        ],
      ),
      child: Text(
        "Aquí irá la información de $nombre",
        style: const TextStyle(fontSize: 18),
      ),
    );
  }

  Widget _botonQR(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(context,
          MaterialPageRoute(builder: (context) => PantallaQR(title: "Pantalla QR", nombreMascota: nombreMascota)),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 255, 161, 79),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 20),
        elevation: 8,
      ),
      child: const Text(
        "QR",
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _tituloSeccion(String titulo) {
    return Text(
      titulo,
      style: const TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }

  Widget _listaRecordatorios(BuildContext context, List<String> recordatorios) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(color: Colors.black26, offset: Offset(0, 2)),
        ],
      ),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: recordatorios.length,
        separatorBuilder: (_, __) => const Divider(),
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(Icons.alarm, color: Colors.blueAccent),
            title: Text(
              recordatorios[index],
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            trailing: const Icon(Icons.arrow_forward_ios, size: 18, color: Colors.grey),
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

  Widget _botonNuevoRecordatorio(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PantallaNuevoRecordatorio(title: 'Nuevo Recordatorio')),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 255, 161, 79),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 20),
        elevation: 8,
      ),
      child: const Text(
        "Nuevo Recordatorio",
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}

