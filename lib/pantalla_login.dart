import 'package:flutter/material.dart';
import 'package:pet_plan_pruebas/pantalla_chatia.dart';
import 'package:pet_plan_pruebas/pantalla_main.dart';
import 'package:pet_plan_pruebas/pantalla_registro.dart';
import 'package:pet_plan_pruebas/pantalla_reset_pass.dart';
import 'package:pet_plan_pruebas/src/widgets/custom_button.dart';
import 'package:pet_plan_pruebas/variables_globales.dart';



class PantallaLogin extends StatefulWidget {
  const PantallaLogin({super.key, required this.title});

  final String title;

  @override
  State<PantallaLogin> createState() => _PantallaLoginState();
}


class _PantallaLoginState extends State<PantallaLogin> {
  //AQUI VAN LAS VARIABLES GLOBALES//
  late TextEditingController _campoUserEmail;
  late TextEditingController _campoUserPass;
  bool _isSecurePassword = true;  

  @override
  void initState(){
    super.initState();
    _campoUserEmail = TextEditingController();
    _campoUserPass = TextEditingController();
  }




  Widget togglePassword(){ //Este es el TOGGLE de ver o no ver la password
    return IconButton(onPressed: (){
      setState(() {
        _isSecurePassword = !_isSecurePassword;
      });
    }, icon: _isSecurePassword ? Icon(Icons.visibility) : Icon(Icons.visibility_off),
    color: Colors.grey);
  }

  void botonEntrar(){  //En el futuro hará mas cosas
    if(_campoUserEmail.text.isNotEmpty && _campoUserPass.text.isNotEmpty){
      VariablesGlobales.loginEmail.add(_campoUserEmail.text);
      VariablesGlobales.loginPassword.add(_campoUserPass.text);
      _campoUserEmail.text = "";
      _campoUserPass.text = "";

      print("Usuarios en la lista: ${VariablesGlobales.loginEmail} \n Contraseñas en la lista: ${VariablesGlobales.loginPassword}");

      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const PantallaPrincipal(title: "PantallaChatIA")));
    }
    else{
      showDialog(context: context, builder: (context) => AlertDialog(
        title: Text("Error🤖"),
        content: Text("No se puede llevar a cabo la acción por algún campo esta vacio, comprueba los datos e intentalo de nuevo", style: TextStyle(fontSize: 19),),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text("Volver", style: TextStyle(fontSize: 19)))
        ],
      ));
      setState(() {
      });
    }
  }

  void cambiarPantallaRegistro(){
   
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const PantallaRegistro(title: "PantallaRegistro")));
  }
  

  @override
  Widget build(BuildContext context) {
    return  Scaffold( backgroundColor: const Color.fromARGB(235, 175, 220, 224),
        body: SingleChildScrollView(child:Column(mainAxisAlignment: MainAxisAlignment.center,
            children:[
              const Divider(height: 80),

              const Text("Pet Plan", style: TextStyle(fontSize: 40, color: Color.fromARGB(255, 226, 138, 23))),
              Padding(padding: EdgeInsets.all(20)),

              SizedBox(
                height: 200.0,
                width: 200.0,
                child: Image.asset("assets/logoLorena.png")

              ),
              Padding(padding: EdgeInsets.all(60)),
              const Text("    -Accede a tu cuenta- \n\n   ¿Aún no tienes cuenta?", style: TextStyle(fontSize: 17, color: Color.fromARGB(218, 0, 0, 0))),
              
              Container(
                  margin:EdgeInsets.only(left: 100, right: 100), //Esto lo separa del margen por la derecha y la izquierda
                  child:
                    CustomButton( 
                       //MI BOTON PRECIOSO para vosotros chat
                      color: Color.fromARGB(0, 0, 0, 0),
                      width: 100.0, //Ancho
                      height: 30.0, //Alto
                      callback: () {
                        cambiarPantallaRegistro();
                      },
                      child: Text("Registrarse", style: TextStyle(fontSize: 17, color: const Color.fromARGB(255, 0, 89, 255), fontStyle: FontStyle.italic)), //Aqui se podria poner una foto
                    ),
                ),


              Padding(padding: EdgeInsets.all(20)),
              Padding(
                padding: const EdgeInsets.all(13),
                child: TextField(  //Este es el campo de texto en el que se van introduciendo el correo del usuario 
                  controller: _campoUserEmail,  //Controlador para identificarlo
                  decoration: const InputDecoration( 
                    border: OutlineInputBorder(),
                    labelText: "Correo",
                    labelStyle: TextStyle(fontSize: 18),
                    ),
                    
                )),

              Padding(
                padding: const EdgeInsets.all(13),
                child: TextField(  //Este es el campo de texto en el que se van introduciendo el password del usuario
                  controller: _campoUserPass, //Controlador para identificarlo
                  obscureText: _isSecurePassword,  //ocultando pass 
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
                    CustomButton( 
                       //MI BOTON PRECIOSO para vosotros chat
                      color: Color.fromARGB(0, 0, 0, 0),
                      width: 300.0, //Ancho
                      height: 30.0, //Alto
                      callback: () {
                         Navigator.of(context).push(MaterialPageRoute(builder: (context) => const PantallaResetPass(title: "PantallaRecuperarContraseña")));
                      },
                      child: Text("¿Has olvidado la contraseña?", style: TextStyle(fontSize: 17, color: const Color.fromARGB(157, 74, 76, 78), fontStyle: FontStyle.italic)), //Aqui se podria poner una foto
                    ),
                ),
                
                Padding(padding: EdgeInsets.all(20)),

                Container(
                  margin:EdgeInsets.only(left: 100, right: 100), //Esto lo separa del margen por la derecha y la izquierda
                  child:
                    CustomButton(  //MI BOTON PRECIOSO para vosotros chat
                      color: Color.fromARGB(216, 150, 65, 163),
                      width: 170.0, //Ancho
                      height: 35.0, //Alto
                      callback: () {
                        botonEntrar();
                      },
                      elevation: 100.0, //Esto añade algo de sombra a la caja elevandolo hacia arriba un poco
                      child: Text("Entrar", style: TextStyle(fontSize: 17, color: const Color.fromARGB(255, 255, 255, 255))), //Aqui se podria poner una foto
                    ),
                ),
                Padding(padding: EdgeInsets.all(40)),

              //ElevatedButton(onPressed: () => print("hola"), child: SizedBox(width: 120, height: 35, child: Center(child: Text("Entrar", style: TextStyle(fontSize: 16, color: const Color.fromARGB(255, 0, 0, 0))) )) )
            ]
          )
        )
    );
  }
}