//import 'dart:nativewrappers/_internal/vm/lib/developer.dart';
import 'dart:developer';


import 'package:flutter/material.dart';
import 'package:pet_plan_pruebas/pantalla_login.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'constructor_registro.dart';
import 'package:pet_plan_pruebas/src/widgets/custom_button.dart';
import 'variables_globales.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

const supabaseUrl = 'https://fzukoqnipqclppkpotbc.supabase.co';
const supabaseKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImZ6dWtvcW5pcHFjbHBwa3BvdGJjIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mzk4NzQ5ODAsImV4cCI6MjA1NTQ1MDk4MH0.Y7fmZFE3SiXvaSaYYNB1Y_WuWvAXNnA9Xdg0aJxEjjc';

class PantallaRegistro extends StatefulWidget {
  const PantallaRegistro({super.key, required this.title});
  

  final String title;

  @override
  State<PantallaRegistro> createState() => _PantallaRegistroState();
}


class _PantallaRegistroState extends State<PantallaRegistro> {
final _supabaseAuth = Supabase.instance.client.auth;
  //VARIABLES//
  final _campoUserEmailReg = TextEditingController();
  final _campoUserNombreReg = TextEditingController();
  final  _campoUserTelefReg = TextEditingController();
  final _campoUserPassReg = TextEditingController();
  

  //late DropdownMenuItem<String> itemsMenu;

  bool _isSecurePassword = true;  


  @override
  void dispose(){
    super.dispose();
    _campoUserEmailReg.dispose();
    _campoUserTelefReg.dispose();
    _campoUserPassReg.dispose();
    //_campoUserEdadReg = DropdownButton();
  }


  
  Widget togglePassword(){ //Este es el TOGGLE de ver o no ver la password
    return IconButton(onPressed: (){
      setState(() {
        _isSecurePassword = !_isSecurePassword;
      });
    }, icon: _isSecurePassword ? Icon(Icons.visibility) : Icon(Icons.visibility_off),
    color: Colors.grey);
  }

  void guardarDatosCambiarPantallaLogin(){
    if(_campoUserEmailReg.text.isNotEmpty && _campoUserEmailReg.text.isNotEmpty && _campoUserTelefReg.text.isNotEmpty){
      
      

      //VariablesGlobales.usuariosRegistrados.add();

      


     // _campoUserEmail.text = "";
     // _campoUserPass.text = "";

      print("Usuarios en la lista: ${VariablesGlobales.loginEmail} \n Contraseñas en la lista: ${VariablesGlobales.loginPassword}");
    

    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const PantallaLogin(title: "Pantalla Login")));
    }
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

                            // Mostrar mensaje emergente (SnackBar)
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Registro exitoso"),
                                duration: Duration(seconds: 3),
                                
                              ),
                            );
                           
                          }
                        }
                        catch (e){
                        print("fallo: $e");
                        }
                      },
                      elevation: 100.0, //Esto añade algo de sombra a la caja elevandolo hacia arriba un poco
                      child: Text("Registrar", style: TextStyle(fontSize: 17, color: const Color.fromARGB(255, 255, 255, 255))), //Aqui se podria poner una foto
                    ),
                ),
            ] //Children
        )
      )
    );
  }
  
}