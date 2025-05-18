import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PantallaEditarMascota extends StatefulWidget {
  const PantallaEditarMascota({super.key, required String title, required String nombreMascota});

  @override
  State<PantallaEditarMascota> createState() => _PantallaEditarMascotaState();
}

class _PantallaEditarMascotaState extends State<PantallaEditarMascota> {
  File? _imagen;
  final picker = ImagePicker();

  Future<void> _seleccionarImagen() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imagen = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFAECBFF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFAECBFF),
        elevation: 0,
        leading: const BackButton(color: Colors.black),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(24),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 8,
                  offset: Offset(2, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Edita tu mascota",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),

                // Imagen de perfil editable
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: _imagen != null
                          ? FileImage(_imagen!)
                          : const AssetImage('assets/default.png')
                              as ImageProvider,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 4,
                      child: GestureDetector(
                        onTap: _seleccionarImagen,
                        child: Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.yellow,
                          ),
                          padding: const EdgeInsets.all(6),
                          child: const Icon(Icons.edit, size: 18),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // Campos de texto
                _campoTexto('Nombre'),
                _campoTexto('Edad'),
                _campoTexto('Animal'),
                _campoTexto('Número de chip'),
                _campoTexto('Raza'),
                _campoTexto('Veterinario'),
                _campoTexto('¿Castrado?'),
                _campoTexto('Nota'),

                const SizedBox(height: 20),

                // Botón Guardar
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green[800],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text("Confirmación"),
                            content: const Text("¿Seguro que quieres guardar esta información?"),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(), // cerrar diálogo
                                child: const Text("No"),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(); // cerrar diálogo
                                  // Aquí podrías guardar los datos
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Información guardada')),
                                  );
                                },
                                child: const Text("Sí"),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: const Text(
                      "Guardar",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _campoTexto(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          border: const UnderlineInputBorder(),
        ),
      ),
    );
  }
}

  