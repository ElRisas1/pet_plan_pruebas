import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';
import 'package:path/path.dart' as path;
import 'package:intl/intl.dart';

class PantallaAgregarMascota extends StatefulWidget {
  const PantallaAgregarMascota({super.key});

  @override
  State<PantallaAgregarMascota> createState() => _PantallaAgregarMascotaState();
}

class _PantallaAgregarMascotaState extends State<PantallaAgregarMascota> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _fechaNacimientoController = TextEditingController();
  final TextEditingController _numeroChipController = TextEditingController();
  final TextEditingController _colorPelajeController = TextEditingController();
  final TextEditingController _informacionExtraController = TextEditingController();
  final TextEditingController _datosVeterinarioController = TextEditingController();

  File? _imagenMascota;
  DateTime? _fechaSeleccionada;
  String? _tipoAnimalSeleccionado;
  List<String> _razas = [];
  String? _razaSeleccionada;
  bool _castrado = false;

  Future<void> _seleccionarImagen() async {
    final ImagePicker picker = ImagePicker();
    final XFile? imagenSeleccionada = await picker.pickImage(source: ImageSource.gallery);
    if (imagenSeleccionada != null) {
      setState(() {
        _imagenMascota = File(imagenSeleccionada.path);
      });
    }
  }

  Future<void> _seleccionarFecha(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _fechaSeleccionada = picked;
        _fechaNacimientoController.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  void _cargarRazas() {
    if (_tipoAnimalSeleccionado == 'Perro') {
      _razas = ['Labrador', 'Bulldog', 'Pastor Alemán', 'Golden Retriever', 'Chihuahua'];
    } else if (_tipoAnimalSeleccionado == 'Gato') {
      _razas = ['Persa', 'Siames', 'Maine Coon', 'Bengalí', 'Esfinge'];
    } else {
      _razas = [];
    }
    _razaSeleccionada = null;
  }

  Future<void> _guardarMascota() async {
    if (_formKey.currentState!.validate()) {
      final user = Supabase.instance.client.auth.currentUser;
      if (user == null) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Debes iniciar sesión")),
        );
        return;
      }

      String? fotoUrl;

      if (_imagenMascota != null) {
        final ext = path.extension(_imagenMascota!.path);
        final fileName = '${const Uuid().v4()}$ext';
        final filePath = 'mascotas/$fileName';
        final bytes = await _imagenMascota!.readAsBytes();

        try {
          final response = await Supabase.instance.client.storage
              .from('imagenesmascotas')
              .uploadBinary(
                filePath,
                bytes,
                fileOptions: const FileOptions(upsert: false),
              );

          print('✅ Imagen subida a: $filePath');
          print('📦 Respuesta: $response');

          fotoUrl = Supabase.instance.client.storage
              .from('imagenesmascotas')
              .getPublicUrl(filePath);

          print('🔗 URL generada: $fotoUrl');
        } catch (e) {
          print('❌ ERROR al subir imagen: $e');
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error al subir la imagen: $e')),
          );
          return;
        }
      }

      try {
        await Supabase.instance.client.from('mascota').insert({
          'Nombre': _nombreController.text,
          'Edad': _fechaNacimientoController.text,
          'Animal': _tipoAnimalSeleccionado,
          'Castrado': _castrado ? 'Sí' : 'No',
          'Color_pelaje': _colorPelajeController.text,
          'Raza': _razaSeleccionada ?? 'Desconocida',
          'Foto': fotoUrl ?? '',
          'Informacion': _informacionExtraController.text,
          'Veterinario': _datosVeterinarioController.text,
          'Num_Chip': _numeroChipController.text,
          'id_usuario': user.id,
        }).select();

        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Mascota guardada correctamente")),
        );
        Navigator.pop(context);
      } catch (e) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error inesperado: $e")),
        );
        print('❌ Error al guardar mascota en la BD: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Agregar Mascota")),
      backgroundColor: const Color.fromARGB(248, 238, 220, 138),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Foto de la mascota", style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Center(
                child: GestureDetector(
                  onTap: _seleccionarImagen,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: _imagenMascota != null
                        ? FileImage(_imagenMascota!)
                        : const AssetImage('assets/default.png') as ImageProvider,
                    child: _imagenMascota == null
                        ? const Icon(Icons.add_a_photo, size: 30, color: Colors.white)
                        : null,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Nombre", style: TextStyle(fontWeight: FontWeight.bold)),
                      TextFormField(
                        controller: _nombreController,
                        decoration: const InputDecoration(hintText: 'Ej: Firulais'),
                        validator: (value) => value == null || value.isEmpty ? 'Ingresa un nombre' : null,
                      ),
                      const SizedBox(height: 20),
                      const Text("Tipo de mascota", style: TextStyle(fontWeight: FontWeight.bold)),
                      DropdownButtonFormField<String>(
                        value: _tipoAnimalSeleccionado,
                        decoration: const InputDecoration(hintText: 'Selecciona tipo de animal'),
                        items: ['Perro', 'Gato']
                            .map((tipo) => DropdownMenuItem(value: tipo, child: Text(tipo)))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            _tipoAnimalSeleccionado = value;
                            _cargarRazas();
                          });
                        },
                        validator: (value) => value == null ? 'Selecciona el tipo de animal' : null,
                      ),
                      const SizedBox(height: 20),
                      const Text("Raza", style: TextStyle(fontWeight: FontWeight.bold)),
                      DropdownButtonFormField<String>(
                        value: _razaSeleccionada,
                        decoration: const InputDecoration(hintText: 'Selecciona una raza'),
                        items: _razas
                            .map((raza) => DropdownMenuItem(value: raza, child: Text(raza)))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            _razaSeleccionada = value;
                          });
                        },
                      ),
                      const SizedBox(height: 20),
                      const Text("Fecha de nacimiento", style: TextStyle(fontWeight: FontWeight.bold)),
                      TextFormField(
                        controller: _fechaNacimientoController,
                        readOnly: true,
                        onTap: () => _seleccionarFecha(context),
                        decoration: const InputDecoration(
                          hintText: 'DD/MM/AAAA',
                          suffixIcon: Icon(Icons.calendar_today),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Selecciona una fecha';
                          }
                          try {
                            DateFormat('dd/MM/yyyy').parseStrict(value);
                            return null;
                          } catch (e) {
                            return 'Formato de fecha inválido';
                          }
                        },
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          const Text("¿Está castrado?", style: TextStyle(fontWeight: FontWeight.bold)),
                          Checkbox(
                            value: _castrado,
                            onChanged: (value) {
                              setState(() {
                                _castrado = value ?? false;
                              });
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      const Text("Número del Chip", style: TextStyle(fontWeight: FontWeight.bold)),
                      TextFormField(
                        controller: _numeroChipController,
                        decoration: const InputDecoration(hintText: 'Ej: 123456'),
                      ),
                      const SizedBox(height: 20),
                      const Text("Color del Pelaje", style: TextStyle(fontWeight: FontWeight.bold)),
                      TextFormField(
                        controller: _colorPelajeController,
                        decoration: const InputDecoration(hintText: 'Ej: Marrón'),
                      ),
                      const SizedBox(height: 20),
                      const Text("Información adicional", style: TextStyle(fontWeight: FontWeight.bold)),
                      TextFormField(
                        controller: _informacionExtraController,
                        decoration: const InputDecoration(hintText: 'Datos adicionales'),
                      ),
                      const SizedBox(height: 20),
                      const Text("Veterinario", style: TextStyle(fontWeight: FontWeight.bold)),
                      TextFormField(
                        controller: _datosVeterinarioController,
                        decoration: const InputDecoration(hintText: 'Nombre o contacto'),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  onPressed: _guardarMascota,
                  child: const Text('Guardar Mascota'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _fechaNacimientoController.dispose();
    _numeroChipController.dispose();
    _colorPelajeController.dispose();
    _informacionExtraController.dispose();
    _datosVeterinarioController.dispose();
    super.dispose();
  }
}
