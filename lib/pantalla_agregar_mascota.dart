// Pantalla para agregar una nueva mascota con diseño visual mejorado
import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';
import 'package:path/path.dart' as path;

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

  Uint8List? _imagenBytes;
  String? _fotoUrl;
  DateTime? _fechaSeleccionada;
  String? _tipoAnimalSeleccionado;
  List<String> _razas = [];
  String? _razaSeleccionada;
  bool _castrado = false;

  Future<void> seleccionarImagen() async {
    final picker = ImagePicker();
    final imagen = await picker.pickImage(source: ImageSource.gallery);
    if (imagen != null) {
      final bytes = await imagen.readAsBytes();
      setState(() {
        _imagenBytes = bytes;
      });
    }
  }

  void _cargarRazas() {
    if (_tipoAnimalSeleccionado == 'Perro') {
      _razas = ['Labrador', 'Bulldog', 'Pastor Alemán'];
    } else if (_tipoAnimalSeleccionado == 'Gato') {
      _razas = ['Siames', 'Persa', 'Bengalí'];
    } else {
      _razas = [];
    }
    _razaSeleccionada = null;
  }

  Future<void> _guardarMascota() async {
    if (_formKey.currentState!.validate()) {
      final user = Supabase.instance.client.auth.currentUser;
      if (user == null) return;

      if (_imagenBytes != null) {
        try {
          final fileName = '${const Uuid().v4()}.jpg';
          final filePath = 'mascotas/$fileName';
          await Supabase.instance.client.storage
              .from('imagenesmascotas')
              .uploadBinary(filePath, _imagenBytes!);

          _fotoUrl = Supabase.instance.client.storage
              .from('imagenesmascotas')
              .getPublicUrl(filePath);
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error al subir imagen: $e')),
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
          'Raza': _razaSeleccionada,
          'Foto': _fotoUrl ?? '',
          'Informacion': _informacionExtraController.text,
          'Veterinario': _datosVeterinarioController.text,
          'Num_Chip': _numeroChipController.text,
          'id_usuario': user.id,
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Mascota guardada correctamente')),
        );
        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al guardar: $e')),
        );
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: seleccionarImagen,
                child: CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.grey[200],
                  backgroundImage:
                      _imagenBytes != null ? MemoryImage(_imagenBytes!) : null,
                  child: _imagenBytes == null
                      ? const Icon(Icons.pets, size: 40, color: Colors.grey)
                      : null,
                ),
              ),
              const SizedBox(height: 20),
              _buildInput("Nombre", _nombreController),
              _buildDropdown("Tipo", ['Perro', 'Gato'], _tipoAnimalSeleccionado,
                  (val) {
                setState(() {
                  _tipoAnimalSeleccionado = val;
                  _cargarRazas();
                });
              }),
              _buildDropdown("Raza", _razas, _razaSeleccionada, (val) {
                setState(() => _razaSeleccionada = val);
              }),
              _buildFecha(),
              CheckboxListTile(
                title: const Text("Está castrado?"),
                value: _castrado,
                onChanged: (val) => setState(() => _castrado = val ?? false),
              ),
              _buildInput("Número de Chip", _numeroChipController),
              _buildInput("Color del Pelaje", _colorPelajeController),
              _buildInput("Información adicional", _informacionExtraController),
              _buildInput("Veterinario", _datosVeterinarioController),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _guardarMascota,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                child: const Text('Guardar Mascota'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInput(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        TextFormField(
          controller: controller,
          validator: (val) => val == null || val.isEmpty ? 'Campo obligatorio' : null,
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildDropdown(String label, List<String> items, String? selectedValue, Function(String?) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        DropdownButtonFormField<String>(
          value: selectedValue,
          items: items
              .map((e) => DropdownMenuItem<String>(value: e, child: Text(e)))
              .toList(),
          onChanged: onChanged,
          validator: (value) => value == null ? 'Campo obligatorio' : null,
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildFecha() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Fecha de nacimiento", style: TextStyle(fontWeight: FontWeight.bold)),
        TextFormField(
          controller: _fechaNacimientoController,
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
                _fechaSeleccionada = picked;
                _fechaNacimientoController.text = DateFormat('dd/MM/yyyy').format(picked);
              });
            }
          },
          validator: (val) => val == null || val.isEmpty ? 'Campo obligatorio' : null,
          decoration: const InputDecoration(suffixIcon: Icon(Icons.calendar_today)),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}