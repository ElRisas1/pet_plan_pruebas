import 'constructor_registro.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

//Variable que guarda en local:
final SharedPreferencesAsync asyncPrefs = SharedPreferencesAsync();

//Aqui se guardarán cosas:

class SharedPreferencesDemoState {
  final Future<SharedPreferencesWithCache> _prefs =
      SharedPreferencesWithCache.create(
          cacheOptions: const SharedPreferencesWithCacheOptions(
              // This cache will only accept the key 'counter'.
              allowList: <String>{'counter'},));
  late Future<int> _counter; //Lo de Future es que es una variable incompleta pero que se llenará en algun momento
}

//-------------------------------------------------------------------





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