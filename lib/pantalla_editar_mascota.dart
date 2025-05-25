import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as path;
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

class PantallaEditarMascota extends StatefulWidget {
  final String title;
  final String nombreMascota;

  const PantallaEditarMascota({
    super.key,
    required this.title,
    required this.nombreMascota,
  });

  @override
  State<PantallaEditarMascota> createState() => _PantallaEditarMascotaState();
}

class _PantallaEditarMascotaState extends State<PantallaEditarMascota> {
  final picker = ImagePicker();
  Uint8List? _imagenBytes;
  String? _fotoUrl;

  final supabase = Supabase.instance.client;

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
    final data = await supabase
        .from('mascota')
        .select()
        .eq('Nombre', widget.nombreMascota)
        .single();

    setState(() {
      nombreController.text = data['Nombre'] ?? '';
      edadController.text = data['Edad'] ?? '';
      especieController.text = data['Animal'] ?? '';
      chipController.text = data['Num_Chip'] ?? '';
      razaController.text = data['Raza'] ?? '';
      vetController.text = data['Veterinario'] ?? '';
      castradoController.text = data['Castrado'] ?? '';
      notaController.text = data['Informacion'] ?? '';
      colorController.text = data['Color_pelaje'] ?? '';
      _fotoUrl = data['Foto'];
    });
  }

  Future<void> _seleccionarImagen() async {
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      final bytes = await picked.readAsBytes();
      setState(() {
        _imagenBytes = bytes;
      });
    }
  }

  Future<void> _guardarDatos() async {
    final user = supabase.auth.currentUser;
    if (user == null) return;

    if (_imagenBytes != null) {
      final fileName = '${const Uuid().v4()}.jpg';
      final filePath = 'mascotas/$fileName';

      try {
        await supabase.storage
            .from('imagenesmascotas')
            .uploadBinary(filePath, _imagenBytes!, fileOptions: const FileOptions(upsert: true));

        final publicUrl = supabase.storage.from('imagenesmascotas').getPublicUrl(filePath);
        _fotoUrl = publicUrl;
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al subir imagen: $e')),
        );
        return;
      }
    }

    final updatedData = {
      'Nombre': nombreController.text,
      'Edad': edadController.text,
      'Animal': especieController.text,
      'Num_Chip': chipController.text,
      'Raza': razaController.text,
      'Veterinario': vetController.text,
      'Castrado': castradoController.text,
      'Informacion': notaController.text,
      'Color_pelaje': colorController.text,
      'Foto': _fotoUrl ?? '',
    };

    try {
      await supabase
          .from('mascota')
          .update(updatedData)
          .eq('Nombre', widget.nombreMascota);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Información actualizada correctamente')),
      );
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al guardar: $e')),
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
    ImageProvider avatarImage;

    if (_imagenBytes != null) {
      avatarImage = MemoryImage(_imagenBytes!);
    } else if (_fotoUrl != null && _fotoUrl!.isNotEmpty) {
      avatarImage = NetworkImage(_fotoUrl!);
    } else {
      avatarImage = const AssetImage('assets/default.png');
    }

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
              boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 8)],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("Edita tu mascota", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: avatarImage,
                      backgroundColor: Colors.grey[300],
                    ),
                    Positioned(
                      bottom: 0,
                      right: 4,
                      child: GestureDetector(
                        onTap: _seleccionarImagen,
                        child: const CircleAvatar(
                          radius: 16,
                          backgroundColor: Colors.yellow,
                          child: Icon(Icons.edit, size: 18, color: Colors.black),
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
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    onPressed: _guardarDatos,
                    child: const Text(
                      "Guardar",
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
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
        decoration: InputDecoration(labelText: label, border: const UnderlineInputBorder()),
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
