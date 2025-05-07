import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
//import 'variables_globales.dart';
import 'package:pet_plan_pruebas/src/widgets/custom_button.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:pet_plan_pruebas/variables_globales.dart';

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

  //Añadiendo List tipo mensajes
  List<Mensaje> mensajes = [
    Mensaje(
     texto: "texto", 
     date: DateTime.now().subtract(Duration(minutes: 1)),
     isSentByMe: false)
  ];

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
  return Scaffold(
    backgroundColor: const Color.fromARGB(248, 152, 184, 239),
    appBar: AppBar(title: Text("Chat IA")),
    body: SafeArea(
      child: Column(
        children: [
          const SizedBox(height: 20),
          const Text(
            "Habla con nuestra IA",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 120,
            width: 120,
            child: Image.asset("assets/logoLorena.png"),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text("La respuesta es: $respuesta", style: TextStyle(fontSize: 18)),
          ),
          Expanded(
            child: GroupedListView<Mensaje, DateTime>(
              elements: mensajes,
              groupBy: (mensaje) => DateTime(2025),
              groupHeaderBuilder: (_) => const SizedBox(),
              itemBuilder: (context, mensaje) => ListTile(
                title: Align(
                  alignment: mensaje.isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: mensaje.isSentByMe ? Colors.blue[100] : Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(mensaje.texto),
                  ),
                ),
              ),
              useStickyGroupSeparators: false,
              floatingHeader: false,
              order: GroupedListOrder.ASC,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _campoPrompt,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Introduce lo que quieras saber",
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: CustomButton(
              color: Colors.transparent,
              width: 100.0,
              height: 40.0,
              callback: () {
                chatIA();
              },
              child: const Text(
                "Enviar",
                style: TextStyle(fontSize: 17, color: Color.fromARGB(255, 0, 89, 255)),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
}