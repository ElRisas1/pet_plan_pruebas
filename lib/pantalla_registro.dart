import 'package:flutter/material.dart';
import 'constructor_registro.dart';

class PantallaRegistro extends StatefulWidget {
  const PantallaRegistro({super.key, required this.title});

  final String title;

  @override
  State<PantallaRegistro> createState() => _PantallaRegistroState();
}


class _PantallaRegistroState extends State<PantallaRegistro> {

  //VARIABLES//
  late TextEditingController _campoUserEmailReg;
  late TextEditingController _campoUserNombreReg;
  late TextEditingController _campoUserTelefReg;
  late TextEditingController _campoUserCPReg;
  var numeros  = 11;
  //late DropdownMenuItem<String> itemsMenu;

  
  String dropDownValue = '12' ; //BOIRBORBOIR dropDownbutton

  @override
  void initState(){
    super.initState();
    _campoUserEmailReg = TextEditingController();
    _campoUserNombreReg = TextEditingController();
    _campoUserTelefReg = TextEditingController();
    _campoUserCPReg = TextEditingController();
    //_campoUserEdadReg = DropdownButton();
  }

  List <DropdownMenuItem<String>> generarNumeros (){ 

    List <DropdownMenuItem<String>> listaItems = []; 

    for(var i =12; i<=80; i++){
        listaItems.add(DropdownMenuItem<String>(
            value: '$i',
            child: Text('$i')));
      }
    return listaItems;
  }




  @override
  Widget build(BuildContext context) {
    return  Scaffold( backgroundColor: const Color.fromARGB(100, 152, 184, 239),
        body: SingleChildScrollView(child:Column(mainAxisAlignment: MainAxisAlignment.center,
            children:[
              AppBar(title: Text("Registro de usuario"),),
              const Divider(height: 80),

              const Text("Pantalla de registro", style: TextStyle(fontSize: 18, color: Colors.black)),
              
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
                  controller: _campoUserTelefReg,  //Controlador para identificarlo
                  decoration: const InputDecoration( 
                    border: OutlineInputBorder(),
                    labelText: "Telefono",
                    labelStyle: TextStyle(fontSize: 18),
                    ),
              )),
            
              //Text field cp
              Padding(padding: EdgeInsets.all(10)),
              Padding(
                padding: const EdgeInsets.all(13),
                child: TextField(  //Este es el campo de texto en el que se van introduciendo el correo del usuario 
                  controller: _campoUserCPReg,  //Controlador para identificarlo
                  decoration: const InputDecoration( 
                    border: OutlineInputBorder(),
                    labelText: "Codigo Postal",
                    labelStyle: TextStyle(fontSize: 18),
                    ),
              )),
              
              //Text field edad
              Padding(padding: EdgeInsets.all(10)),
              Padding(
                padding: const EdgeInsets.all(13),
                child: DropdownButton<String>( 
                  value: dropDownValue,
                  icon: const Icon(Icons.arrow_drop_down),
                  style: TextStyle(color: Colors.black),
                  underline: Container(
                    height: 2,
                    color:  Colors.black,
                  ),
                  onChanged: (String? newValue){
                    setState(() {
                      dropDownValue = newValue!;
                    });
                  },
                  
                  items: generarNumeros() 
                ),
              ),
            ] //Children
        )
      )
    );
  }
}