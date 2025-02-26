import 'package:flutter/material.dart';
import 'constructor_registro.dart';
import 'package:pet_plan_pruebas/src/widgets/custom_button.dart';


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

  
  String dropDownDefaultValue = '12' ; //BOIRBORBOIR dropDownbutton

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
            
              //Text field cp
              Padding(padding: EdgeInsets.all(10)),
              Padding(
                padding: const EdgeInsets.all(13),
                child: TextField(  //Este es el campo de texto en el que se van introduciendo el correo del usuario 
                  controller: _campoUserCPReg,  //Controlador para identificarlo
                  keyboardType: TextInputType.numberWithOptions(), //Solo ofrece teclado numerico
                  decoration: const InputDecoration( 
                    border: OutlineInputBorder(),
                    labelText: "Codigo Postal",
                    labelStyle: TextStyle(fontSize: 18),
                    ),
              )),
              
              //Text field edad
              Padding(padding: EdgeInsets.all(10)),
              Row(mainAxisAlignment: MainAxisAlignment.center,
                //padding: const EdgeInsets.all(13),
                
                children:[
                  
                  Text("Selecciona edad", style: TextStyle(fontSize: 18)),
                  Padding(padding: EdgeInsets.all(60)),

                  DropdownButton<String>( 
                  value: dropDownDefaultValue,
                  icon: const Icon(Icons.arrow_drop_down),
                  style: TextStyle(color: Colors.black),
                  underline: Container(
                    height: 2,
                    color:  Colors.black,
                  ),
                  onChanged: (String? newValue){
                    setState(() {
                      dropDownDefaultValue = newValue!;
                    });
                  },
                  
                  items: generarNumeros() 
                ),] 
              ),

               Container(
                  margin:EdgeInsets.only(left: 100, right: 100), //Esto lo separa del margen por la derecha y la izquierda
                  child:
                    CustomButton(  //MI BOTON PRECIOSO para vosotros chat
                      color: Color.fromARGB(215, 163, 65, 122),
                      width: 170.0, //Ancho
                      height: 35.0, //Alto
                      callback: () {
                        print("Boton crear Usuario pulsado");
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