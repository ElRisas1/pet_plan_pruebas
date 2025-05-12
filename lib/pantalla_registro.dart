import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pet_plan_pruebas/pantalla_login.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:pet_plan_pruebas/src/widgets/custom_button.dart';

class PantallaRegistro extends StatefulWidget {
  const PantallaRegistro({super.key, required this.title});
  final String title;

  @override
  State<PantallaRegistro> createState() => _PantallaRegistroState();
}

class _PantallaRegistroState extends State<PantallaRegistro> {
  final _supabaseAuth = Supabase.instance.client.auth;

  final _campoUserEmailReg = TextEditingController();
  final _campoUserNombreReg = TextEditingController();
  final _campoUserTelefReg = TextEditingController();
  final _campoUserPassReg = TextEditingController();
  final _campoUserEdadReg = TextEditingController();
  final _campoUserDireccionReg = TextEditingController();
  final _campoUserCPReg = TextEditingController();

  bool _isSecurePassword = true;

  @override
  void dispose() {
    _campoUserEmailReg.dispose();
    _campoUserNombreReg.dispose();
    _campoUserTelefReg.dispose();
    _campoUserPassReg.dispose();
    _campoUserEdadReg.dispose();
    _campoUserDireccionReg.dispose();
    _campoUserCPReg.dispose();
    super.dispose();
  }

  Widget togglePassword() {
    return IconButton(
      onPressed: () {
        setState(() {
          _isSecurePassword = !_isSecurePassword;
        });
      },
      icon: Icon(
        _isSecurePassword ? Icons.visibility : Icons.visibility_off,
        color: Colors.grey,
      ),
    );
  }

  Future<void> insertarUsuario(String userId) async {
    final supabase = Supabase.instance.client;

    try {
      await supabase.from('Usuarios').insert({
        'Nombre': _campoUserNombreReg.text,
        'Contrasena': _campoUserPassReg.text,
        'Edad': int.tryParse(_campoUserEdadReg.text) ?? 0,
        'Telefono': int.tryParse(_campoUserTelefReg.text) ?? 0,
        'Correo': _campoUserEmailReg.text,
        'Direccion': _campoUserDireccionReg.text,
        'CP': int.tryParse(_campoUserCPReg.text) ?? 0,
        'user_id': userId,
      });

      log("Usuario insertado correctamente.");
    } catch (e) {
      log("Error al insertar usuario: $e");
    }
  }

  void guardarDatosCambiarPantallaLogin() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const PantallaLogin(title: "Pantalla Login"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(236, 187, 205, 235),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppBar(title: const Text("Registro de usuario")),
            const Divider(height: 80),
            const Text(
              "Pantalla de registro",
              style: TextStyle(fontSize: 28, color: Colors.black),
            ),
            const SizedBox(height: 20),

            // Campos de texto
            campoTexto("Correo", _campoUserEmailReg),
            campoTexto("Nombre", _campoUserNombreReg),
            campoTexto("Teléfono", _campoUserTelefReg,
                tipo: TextInputType.number),
            campoTexto("Edad", _campoUserEdadReg,
                tipo: TextInputType.number),
            campoTexto("Dirección", _campoUserDireccionReg),
            campoTexto("Código Postal", _campoUserCPReg,
                tipo: TextInputType.number),

            Padding(
              padding: const EdgeInsets.all(13),
              child: TextField(
                controller: _campoUserPassReg,
                obscureText: _isSecurePassword,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: "Contraseña",
                  labelStyle: const TextStyle(fontSize: 18),
                  suffixIcon: togglePassword(),
                ),
              ),
            ),

            const SizedBox(height: 15),

            Container(
              margin: const EdgeInsets.symmetric(horizontal: 100),
              child: CustomButton(
                color: const Color.fromARGB(215, 163, 65, 122),
                width: 170.0,
                height: 35.0,
                callback: () async {
                  try {
                    final res = await _supabaseAuth.signUp(
                      email: _campoUserEmailReg.text,
                      password: _campoUserPassReg.text,
                    );

                    if (res.user != null) {
                      log("Registrado con éxito");
                      await insertarUsuario(res.user!.id);
                      guardarDatosCambiarPantallaLogin();

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Registro exitoso"),
                          duration: Duration(seconds: 3),
                        ),
                      );
                    }
                  } catch (e) {
                    log("Fallo en registro: $e");
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Error: $e"),
                        duration: const Duration(seconds: 4),
                      ),
                    );
                  }
                },
                elevation: 100.0,
                child: const Text(
                  "Registrar",
                  style: TextStyle(fontSize: 17, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding campoTexto(String label, TextEditingController controller,
      {TextInputType tipo = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.all(13),
      child: TextField(
        controller: controller,
        keyboardType: tipo,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: label,
          labelStyle: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}

