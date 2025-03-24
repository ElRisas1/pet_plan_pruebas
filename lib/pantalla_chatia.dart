import 'package:flutter/material.dart';
//import 'variables_globales.dart';
import 'package:pet_plan_pruebas/src/widgets/custom_button.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class PantallaChatIA extends StatefulWidget {
  const PantallaChatIA({super.key, required this.title});

  final String title;

  @override
  State<PantallaChatIA> createState() => _PantallaChatIAState();
}

class _PantallaChatIAState extends State<PantallaChatIA> {

  //AQUI VAN LAS VARIABLES GLOBALES//
  final apiKey = 'AIzaSyBhCntUyCG397ROTUdrp8q7lNCKI5oLL8k';
  late TextEditingController _campoPrompt;
  String respuesta = "";


  @override
  void initState(){
    super.initState();
    _campoPrompt = TextEditingController();
  }


  void chatIA() async {

    final model = GenerativeModel(
      model: 'gemini-1.5-flash-latest',
      apiKey: apiKey,
    );

    final prompt = _campoPrompt.text;
    final content = [Content.text(prompt)];
    final response = await model.generateContent(content);

    
    respuesta = response.text!.replaceAll(RegExp(r'\**'), '').toString();
    print(response.text);
    _campoPrompt.text = "";
    setState(() {});
  }

  
  @override
  Widget build(BuildContext context) {
      return  Scaffold( 
        backgroundColor: const Color.fromARGB(248, 152, 184, 239),
        appBar: AppBar(title: Text("Chat IA")),
        body: SingleChildScrollView(child:Column(mainAxisAlignment: MainAxisAlignment.center,
            children:[
              const Divider(height: 80),
              const Text("Habla con nuestra IA", style: TextStyle(fontSize: 37, color: Color.fromARGB(255, 0, 0, 0))),
              Padding(padding: EdgeInsets.all(20)),

              SizedBox(
                height: 200.0,
                width: 200.0,
                child: Image.asset("assets/logoLorena.png")

              ),

              
              Padding(
                padding: const EdgeInsets.all(13),
                child: TextField(  //Este es el campo de texto en el que se van introduciendo el correo del usuario 
                  controller: _campoPrompt,  //Controlador para identificarlo
                  decoration: const InputDecoration( 
                    border: OutlineInputBorder(),
                    labelText: "Introduce lo que quieras saber",
                    labelStyle: TextStyle(fontSize: 18),
                    ),
                    
                )
              ),


              Padding(padding: EdgeInsets.all(25),
                child: Text("La respuesta es: $respuesta", style: TextStyle(fontSize: 20),)
                ),
              

              Padding(padding: EdgeInsets.all(20)),
              Container(
                margin:EdgeInsets.only(left: 100, right: 100), //Esto lo separa del margen por la derecha y la izquierda
                child:
                  CustomButton(  //MI BOTON PRECIOSO para vosotros chat
                    color: Color.fromARGB(0, 0, 0, 0),
                    width: 100.0, //Ancho
                    height: 30.0, //Alto
                    callback: () {
                      chatIA();
                    },
                    child: Text("Enviar", style: TextStyle(fontSize: 17, color: const Color.fromARGB(255, 0, 89, 255), fontStyle: FontStyle.normal)), //Aqui se podria poner una foto
                  ),
                ),
              Padding(padding: EdgeInsets.all(20)),

             ] //Children  
        )
        )
      );
  } //Build
} //Final de la class