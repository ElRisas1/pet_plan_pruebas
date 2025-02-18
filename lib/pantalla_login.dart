import 'package:flutter/material.dart';
import 'package:pet_plan_pruebas/src/widgets/custom_button.dart';


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



  @override
  Widget build(BuildContext context) {
    return  Scaffold( backgroundColor: const Color.fromARGB(100, 152, 184, 239),
        body: SingleChildScrollView(child:Column(mainAxisAlignment: MainAxisAlignment.start,
            children:[
              const Divider(height: 60),

              const Text("Pet Plan", style: TextStyle(fontSize: 40, color: Color.fromARGB(255, 226, 138, 23))),
              Padding(padding: EdgeInsets.all(20)),

              SizedBox(
                height: 200.0,
                width: 200.0,
                child: Image.asset("assets/logoLorena.png"),

              ),
              Padding(padding: EdgeInsets.all(60)),
              const Text("-Login into your account-", style: TextStyle(fontSize: 17, color: Color.fromARGB(218, 0, 0, 0))),
              
              Padding(padding: EdgeInsets.all(20)),
              Padding(
                padding: const EdgeInsets.all(13),
                child: TextField(  //Este es el campo de texto en el que se van
                  controller: _campoUserEmail,  //introduciendo el correo del usuario 
                  decoration: const InputDecoration( 
                    border: OutlineInputBorder(),
                    labelText: "Introduce un correo..."),
                )),

              Padding(
                padding: const EdgeInsets.all(13),
                child: TextField(  //Este es el campo de texto en el que se van
                  controller: _campoUserPass, //introduciendo el password del usuario
                  obscureText: _isSecurePassword,  //ocultando pass 
                  decoration:  InputDecoration( 
                    border: OutlineInputBorder(),
                    labelText: "Introduce la contraseña...",
                      suffixIcon: togglePassword(),
                  ),
                     
                )),
                Container(
                  margin:EdgeInsets.only(left: 100, right: 100), //Esto lo separa del margen por la derecha y la izquierda
                  child:
                    CustomButton(  //MI BOTON PRECIOSO para vosotros chat
                      color: Color.fromARGB(99, 59, 179, 87),
                      width: 170.0, //Ancho
                      height: 35.0, //Alto
                      callback: () {
                      },
                      elevation: 100.0, //Esto añade algo de sombra a la caja elevandolo hacia arriba un poco
                      child: Text("Entrar", style: TextStyle(fontSize: 17, color: Colors.black)), //Aqui se podria poner una foto
                    )
                )
              //ElevatedButton(onPressed: () => print("hola"), child: SizedBox(width: 120, height: 35, child: Center(child: Text("Entrar", style: TextStyle(fontSize: 16, color: const Color.fromARGB(255, 0, 0, 0))) )) )
            ]
          )
        )
    );
  }
}