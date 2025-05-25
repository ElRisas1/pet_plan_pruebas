import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:intl/intl.dart';

class PantallaEditarMascota extends StatefulWidget {
  final String title;
  final String nombreMascota;

  const PantallaEditarMascota({super.key, required this.title, required this.nombreMascota});

  @override
  State<PantallaEditarMascota> createState() => _PantallaEditarMascotaState();
}

class _PantallaEditarMascotaState extends State<PantallaEditarMascota> {
  File? _imagen;
  final picker = ImagePicker();

  final TextEditingController nombreController = TextEditingController();
  final TextEditingController edadController = TextEditingController();
  final TextEditingController especieController = TextEditingController();
  final TextEditingController chipController = TextEditingController();
  final TextEditingController razaController = TextEditingController();
  final TextEditingController vetController = TextEditingController();
  final TextEditingController castradoController = TextEditingController();
  final TextEditingController notaController = TextEditingController();
  final TextEditingController colorController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _cargarDatosMascota();
  }

  Future<void> _cargarDatosMascota() async {
    final response = await Supabase.instance.client
        .from('mascota')
        .select()
        .eq('Nombre', widget.nombreMascota)
        .single();

    setState(() {
      nombreController.text = response['Nombre'] ?? '';
      edadController.text = response['Edad'] ?? '';
      especieController.text = response['Animal'] ?? '';
      chipController.text = response['Num_Chip'] ?? '';
      razaController.text = response['Raza'] ?? '';
      vetController.text = response['Veterinario'] ?? '';
      castradoController.text = response['Castrado'] ?? '';
      notaController.text = response['Informacion'] ?? '';
      colorController.text = response['Color_pelaje'] ?? '';
    });
  }

  Future<void> _seleccionarImagen() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imagen = File(pickedFile.path);
      });
    }
  }

  Future<void> _guardarDatos() async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) return;

    final data = {
      'Nombre': nombreController.text,
      'Edad': edadController.text,
      'Animal': especieController.text,
      'Num_Chip': chipController.text,
      'Raza': razaController.text,
      'Veterinario': vetController.text,
      'Castrado': castradoController.text,
      'Informacion': notaController.text,
      'Color_pelaje': colorController.text,
    };

    try {
      await Supabase.instance.client
          .from('mascota')
          .update(data)
          .eq('Nombre', widget.nombreMascota);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Información actualizada correctamente')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al guardar: \$e')),
      );
    }
  }

  @override
  void dispose() {
    nombreController.dispose();
    edadController.dispose();
    especieController.dispose();
    chipController.dispose();
    razaController.dispose();
    vetController.dispose();
    castradoController.dispose();
    notaController.dispose();
    colorController.dispose();
    super.dispose();
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
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: _imagen != null
                          ? FileImage(_imagen!)
                          : const AssetImage('assets/default.png') as ImageProvider,
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
                _campoTexto('Nombre', nombreController),
                _campoFecha('Edad (dd/MM/yyyy)', edadController),
                _campoTexto('Especie', especieController),
                _campoTexto('N° Chip', chipController),
                _campoTexto('Raza', razaController),
                _campoTexto('Color del Pelaje', colorController),
                _campoTexto('Veterinario', vetController),
                _campoTexto('¿Castrado?', castradoController),
                _campoTexto('Nota', notaController),
                const SizedBox(height: 20),
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
                                onPressed: () => Navigator.of(context).pop(),
                                child: const Text("No"),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  _guardarDatos();
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

  Widget _campoTexto(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const UnderlineInputBorder(),
        ),
      ),
    );
  }

  Widget _campoFecha(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: TextFormField(
        controller: controller,
        readOnly: true,
        onTap: () async {
          final picked = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime.now(),
          );
          if (picked != null) {
            setState(() {
              controller.text = DateFormat('dd/MM/yyyy').format(picked);
            });
          }
        },
        decoration: InputDecoration(
          labelText: label,
          border: const UnderlineInputBorder(),
          suffixIcon: const Icon(Icons.calendar_today),
        ),
      ),
    );
  }
}