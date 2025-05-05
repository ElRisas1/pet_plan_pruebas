import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pet_plan_pruebas/pantalla_login.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:pet_plan_pruebas/src/widgets/custom_button.dart';
import 'variables_globales.dart';

class PantallaRegistro extends StatefulWidget {
  const PantallaRegistro({super.key, required this.title});
  final String title;

  @override
  State<PantallaRegistro> createState() => _PantallaRegistroState();
}

class _PantallaRegistroState extends State<PantallaRegistro> {
  final _supabaseAuth = Supabase.instance.client.auth;

  // Controladores
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
      icon: _isSecurePassword
          ? const Icon(Icons.visibility)
          : const Icon(Icons.visibility_off),
      color: Colors.grey,
    );
  }

  Future<void> insertarUsuario(String userId) async {
    final supabase = Supabase.instance.client;

    final response = await supabase.from('Usuarios').insert({
      'Nombre': _campoUserNombreReg.text,
      'Contrasena': _campoUserPassReg.text,
      'Edad': int.tryParse(_campoUserEdadReg.text) ?? 0,
      'Telefono': int.tryParse(_campoUserTelefReg.text) ?? 0,
      'Correo': _campoUserEmailReg.text,
      'Direccion': _campoUserDireccionReg.text,
      'CP': int.tryParse(_campoUserCPReg.text) ?? 0,
      'user_id': userId, // Enlace con tabla de autenticación
    });

    if (response.error != null) {
      log("Error al insertar: ${response.error!.message}");
    } else {
      log("Usuario insertado correctamente.");
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
            const Text("Pantalla de registro",
                style: TextStyle(fontSize: 28, color: Colors.black)),

            const SizedBox(height: 20),

            // Correo
            Padding(
              padding: const EdgeInsets.all(13),
              child: TextField(
                controller: _campoUserEmailReg,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Correo",
                  labelStyle: TextStyle(fontSize: 18),
                ),
              ),
            ),

            // Nombre
            Padding(
              padding: const EdgeInsets.all(13),
              child: TextField(
                controller: _campoUserNombreReg,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Nombre",
                  labelStyle: TextStyle(fontSize: 18),
                ),
              ),
            ),

            // Teléfono
            Padding(
              padding: const EdgeInsets.all(13),
              child: TextField(
                controller: _campoUserTelefReg,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Teléfono",
                  labelStyle: TextStyle(fontSize: 18),
                ),
              ),
            ),

            // Edad
            Padding(
              padding: const EdgeInsets.all(13),
              child: TextField(
                controller: _campoUserEdadReg,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Edad",
                  labelStyle: TextStyle(fontSize: 18),
                ),
              ),
            ),

            // Dirección
            Padding(
              padding: const EdgeInsets.all(13),
              child: TextField(
                controller: _campoUserDireccionReg,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Dirección",
                  labelStyle: TextStyle(fontSize: 18),
                ),
              ),
            ),

            // Código Postal
            Padding(
              padding: const EdgeInsets.all(13),
              child: TextField(
                controller: _campoUserCPReg,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Código Postal",
                  labelStyle: TextStyle(fontSize: 18),
                ),
              ),
            ),

            // Contraseña
            Padding(
              padding: const EdgeInsets.all(13),
              child: TextField(
                controller: _campoUserPassReg,
                obscureText: _isSecurePassword,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: "Contraseña",
                  labelStyle: const TextStyle(fontSize: 18),
                  suffixIcon: togglePassword(),
                ),
              ),
            ),

            const SizedBox(height: 15),

            // Botón Registrar
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
}
