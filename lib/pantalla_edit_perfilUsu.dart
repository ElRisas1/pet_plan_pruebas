import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PantallaEditPerfilUsu extends StatefulWidget {
  const PantallaEditPerfilUsu({super.key, required String title});

  @override
  State<PantallaEditPerfilUsu> createState() => _PantallaEditPerfilUsuState();
}

class _PantallaEditPerfilUsuState extends State<PantallaEditPerfilUsu> {
  File? _imagen;
  final picker = ImagePicker();
  final supabase = Supabase.instance.client;

  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _nicknameController = TextEditingController();
  final TextEditingController _edadController = TextEditingController();
  final TextEditingController _telefonoController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _direccionController = TextEditingController();
  final TextEditingController _cpController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _cargarDatosUsuario();
  }

  Future<void> _cargarDatosUsuario() async {
    final user = supabase.auth.currentUser;
    if (user == null) return;

    final data = await supabase
        .from('Usuarios')
        .select()
        .eq('user_id', user.id)
        .single();

    setState(() {
      _nombreController.text = data['Nombre'] ?? '';
      _nicknameController.text = user.userMetadata?['nickname'] ?? '';
      _edadController.text = data['Edad']?.toString() ?? '';
      _telefonoController.text = data['Telefono']?.toString() ?? '';
      _emailController.text = data['Correo'] ?? '';
      _direccionController.text = data['Direccion'] ?? '';
      _cpController.text = data['CP']?.toString() ?? '';
    });
  }

  Future<void> _guardarDatos() async {
    final user = supabase.auth.currentUser;
    if (user == null) return;

    await supabase.from('Usuarios').update({
      'Nombre': _nombreController.text,
      'Edad': int.tryParse(_edadController.text),
      'Telefono': int.tryParse(_telefonoController.text),
      'Correo': _emailController.text,
      'Direccion': _direccionController.text,
      'CP': int.tryParse(_cpController.text),
    }).eq('user_id', user.id);

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Información guardada')),
    );
  }

  Future<void> _seleccionarImagen() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imagen = File(pickedFile.path);
      });
      // Aquí podrías subir la imagen a Supabase Storage si lo deseas
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
                  "Edita tu perfil",
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

                _campoTexto('Nombre', _nombreController),
                _campoTexto('Nickname', _nicknameController),
                _campoTexto('Edad', _edadController),
                _campoTexto('Telefono', _telefonoController),
                _campoTexto('Email', _emailController),
                _campoTexto('Dirección', _direccionController),
                _campoTexto('Código Postal', _cpController),

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
                    onPressed: _guardarDatos,
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
}
  
