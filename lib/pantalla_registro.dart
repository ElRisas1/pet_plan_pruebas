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
  

  //late DropdownMenuItem<String> itemsMenu;

  bool _isSecurePassword = true;

  @override
  void dispose() {
    _campoUserEmailReg.dispose();
    _campoUserNombreReg.dispose();
    _campoUserTelefReg.dispose();
    _campoUserPassReg.dispose();
    //_campoUserEdadReg = DropdownButton();
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
    return  Scaffold( backgroundColor: const Color.fromARGB(236, 187, 205, 235),
        body: SingleChildScrollView(child:Column(mainAxisAlignment: MainAxisAlignment.center,
            children:[
              AppBar(title: Text("Registro de usuario"),),
              const Divider(height: 80),

              const Text("Pantalla de registro", style: TextStyle(fontSize: 28, color: Colors.black)),
              
              //Text field correo
              Padding(padding: EdgeInsets.all(40)),
              Padding(
                padding: const EdgeInsets.all(13),
                child: TextField(  //Este es el campo de texto en el que se van introduciendo el correo del usuario 
                  controller: _campoUserEmailReg,  //Controlador para identificarlo
                  decoration: const InputDecoration( 
                    border: OutlineInputBorder(),
                    labelText: "Correo",
                    labelStyle: TextStyle(fontSize: 18),
                    ),
              )),

              //Text field nombre
              Padding(padding: EdgeInsets.all(10)),
              Padding(
                padding: const EdgeInsets.all(13),
                child: TextField(  //Este es el campo de texto en el que se van introduciendo el correo del usuario 
                  controller: _campoUserNombreReg,  //Controlador para identificarlo
                  decoration: const InputDecoration( 
                    border: OutlineInputBorder(),
                    labelText: "Nombre",
                    labelStyle: TextStyle(fontSize: 18),
                    ),
                )),

              //Text field Telefono
              Padding(padding: EdgeInsets.all(10)),
              Padding(
                padding: const EdgeInsets.all(13),
                child: TextField(  //Este es el campo de texto en el que se van introduciendo el correo del usuario 
                  controller: _campoUserTelefReg, //Controlador para identificarlo
                  keyboardType: TextInputType.numberWithOptions(), //Solo ofrece teclado numerico
                  decoration: const InputDecoration( 
                    border: OutlineInputBorder(),
                    labelText: "Telefono",
                    labelStyle: TextStyle(fontSize: 18),
                    ),
              )),

                Padding(padding: EdgeInsets.all(10)),
              Padding(
                padding: const EdgeInsets.all(13),
                child: TextField(  //Este es el campo de texto en el que se van introduciendo el correo del usuario 
                  controller: _campoUserPassReg, 
                  obscureText: _isSecurePassword,
                  //Controlador para identificarlo
                  keyboardType: TextInputType.numberWithOptions(), //Solo ofrece teclado numerico
                  decoration:  InputDecoration( 
                    border: OutlineInputBorder(),
                    labelText: "Contraseña",
                    labelStyle: TextStyle(fontSize: 18),
                    suffixIcon: togglePassword(),
                    ),
              )),
    
               Container(
                  margin:EdgeInsets.only(left: 100, right: 100), //Esto lo separa del margen por la derecha y la izquierda
                  child:
                    CustomButton(  //MI BOTON PRECIOSO para vosotros chat
                      color: Color.fromARGB(215, 163, 65, 122),
                      width: 170.0, //Ancho
                      height: 35.0, //Alto
                      callback: () async {
                        print("HOLA");
                        try{
                          final res = await _supabaseAuth.signUp(
                          email: _campoUserEmailReg.text,
                          password: _campoUserPassReg.text,
                          );
                          print(res);
                          if (res.user != null) {
                            log("Registrado");
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
