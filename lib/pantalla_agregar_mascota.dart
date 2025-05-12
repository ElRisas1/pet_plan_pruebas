import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
//Pantallas

// Pantalla para agregar mascota

class PantallaAgregarMascota extends StatefulWidget {
  const PantallaAgregarMascota({super.key});

  @override
  State<PantallaAgregarMascota> createState() => _PantallaAgregarMascotaState();
}

class _PantallaAgregarMascotaState extends State<PantallaAgregarMascota> {

  final _formKey = GlobalKey<FormState>(); // Clave para validar el formulario.
  final TextEditingController _nombreController = TextEditingController(); // Para leer el campo "nombre".
  final TextEditingController _tipoController = TextEditingController();   // Para leer el campo "tipo de mascota".
  final TextEditingController _fechaNacimientoController = TextEditingController(); // Para leer "fecha de nacimiento".

  File? _imagenMascota; // Variable que guardará la imagen seleccionada.

  // FUNCION para seleccionar una imagen.
  Future<void> _seleccionarImagen() async {
    final ImagePicker picker = ImagePicker();
    final XFile? imagenSeleccionada = await picker.pickImage(source: ImageSource.gallery); // esta linea abre la galería.

    if (imagenSeleccionada != null) {
      setState(() {
        _imagenMascota = File(imagenSeleccionada.path); // Guarda la imagen seleccionada en la variable.
      });
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
          key: _formKey, // Asocia el formulario a la clave para validación.
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Foto de la mascota", style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Center(
                child: GestureDetector(
                  onTap: _seleccionarImagen, // Al tocar el avatar, se abre la galería.
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: _imagenMascota != null
                        ? FileImage(_imagenMascota!) // Muestra imagen si fue cargada
                        : const AssetImage('assets/default.png') as ImageProvider, // Imagen por defecto
                    child: _imagenMascota == null
                        ? const Icon(Icons.add_a_photo, size: 30, color: Colors.white) // Ícono si no hay imagen
                        : null,
                  ),
                ),
              ),
              const SizedBox(height: 30),

              const Text("Nombre de la mascota", style: TextStyle(fontWeight: FontWeight.bold)),
              TextFormField(
                controller: _nombreController,
                decoration: const InputDecoration(hintText: 'Ej: Firulais'),
                validator: (value) => value == null || value.isEmpty ? 'Ingresa un nombre' : null,
              ),
              const SizedBox(height: 20),

              const Text("Tipo de mascota", style: TextStyle(fontWeight: FontWeight.bold)),
              TextFormField(
                controller: _tipoController,
                decoration: const InputDecoration(hintText: 'Ej: Perro, Gato'),
              ),
              const SizedBox(height: 20),

              const Text("Fecha de nacimiento", style: TextStyle(fontWeight: FontWeight.bold)),
              TextFormField(
                controller: _fechaNacimientoController,
                decoration: const InputDecoration(hintText: 'DD/MM/AAAA'),
              ),
              const SizedBox(height: 40),

              //Boton de guardar.
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final nombre = _nombreController.text;

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Mascota '$nombre' guardada")),
                      );

                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Guardar Mascota'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  //Limpia la pantalla al salirse.
  @override
  void dispose() {
    _nombreController.dispose();
    _tipoController.dispose();
    _fechaNacimientoController.dispose();
    super.dispose();
  }
}
