import 'constructor_registro.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class VariablesGlobales {

  static List <String> loginEmail = [];

  static List <String> loginPassword = [];

  static List <ConstructorRegistro> usuariosRegistrados = [];
}

class Mensaje {
  final String texto;
  final DateTime date;
  final bool isSentByMe;

  const Mensaje ({
    required this.texto,
    required this.date,
    required this.isSentByMe,
  });
}


//API MODEL GEMINI

class IaChatResponse{
  void chatIA() async {

  final apiKey = 'AIzaSyBhCntUyCG397ROTUdrp8q7lNCKI5oLL8k';

  final model = GenerativeModel(
    model: 'gemini-1.5-flash-latest',
    apiKey: apiKey,
  );

  final prompt = 'What you want';
  final content = [Content.text(prompt)];
  final response = await model.generateContent(content);

  print(response.text);
  }
}