import 'package:flutter/material.dart';
 import 'package:pet_plan_pruebas/pantalla_login.dart';
 import 'constructor_registro.dart';
 import 'package:pet_plan_pruebas/src/widgets/custom_button.dart';
 import 'variables_globales.dart';
 
 
 class PantallaResetPass extends StatefulWidget {
   const PantallaResetPass({super.key, required this.title});
 
   final String title;
 
   @override
   State<PantallaResetPass> createState() => _PantallaResetPassState();
 }
 
 
 class _PantallaResetPassState extends State<PantallaResetPass> {
 
   //VARIABLES//
   late TextEditingController _campoUserEmailReg;
   late TextEditingController _campoUserPassreset;
   late TextEditingController _campoUserPassCode;
   bool _isSecurePassword = true;  
   //late DropdownMenuItem<String> itemsMenu;
 
   
 
   @override
   void initState(){
     super.initState();
     _campoUserEmailReg = TextEditingController();
     _campoUserPassreset = TextEditingController();
     _campoUserPassCode = TextEditingController();
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
     if(_campoUserEmailReg.text.isNotEmpty && _campoUserPassreset.text.isNotEmpty){
       
       
 
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
               AppBar(title: Text("Recuperar la contraseña"),),
               const Divider(height: 80),
 
               const Text("Recuperar la contraseña", style: TextStyle(fontSize: 28, color: Colors.black)),
 
               Padding(
                 padding: const EdgeInsets.all(20),
                 child: const Text("Se te va a enviar un codigo al correo que introduzcas para recuperar la contraseña de esa cuenta", 
                     style: TextStyle(fontSize: 21, color: Colors.black)),
               ),
               
               //Text field correo
               Padding(padding: EdgeInsets.all(40)),
               Padding(
                 padding: const EdgeInsets.all(13),
                 child: TextField(  //Este es el campo de texto en el que se van introduciendo el correo del usuario 
                   controller: _campoUserEmailReg,  //Controlador para identificarlo
                   decoration: const InputDecoration( 
                     border: OutlineInputBorder(),
                     labelText: "Correo del Usuario registrado",
                     labelStyle: TextStyle(fontSize: 18),
                     ),
               )),
 
               //Text field Telefono
               Padding(padding: EdgeInsets.all(10)),
               Padding(
                 padding: const EdgeInsets.all(13),
                 child: TextField(  //Este es el campo de texto en el que se van introduciendo el correo del usuario 
                   controller: 
                     _campoUserPassreset,
                     obscureText: _isSecurePassword, //Controlador para identificarlo
                   keyboardType: TextInputType.numberWithOptions(), //Solo ofrece teclado numerico
                   decoration: InputDecoration( 
                     border: OutlineInputBorder(),
                     labelText: "Contraseña nueva",
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
                       callback: () {
                         guardarDatosCambiarPantallaLogin();
                         
                       },
                       elevation: 100.0, //Esto añade algo de sombra a la caja elevandolo hacia arriba un poco
                       child: Text("Entrar", style: TextStyle(fontSize: 17, color: const Color.fromARGB(255, 255, 255, 255))), //Aqui se podria poner una foto
                     ),
                 ),
             ] //Children
         )
       )
     );
   }
   
 }