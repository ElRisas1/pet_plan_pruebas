import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class PantallaAyuda extends StatefulWidget {
  const PantallaAyuda({super.key, required this.title, required String opcionesAjustes});

  final String title;

  @override
  _PantallaAyudaState createState() => _PantallaAyudaState();
}

class _PantallaAyudaState extends State<PantallaAyuda> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 152, 184, 239),
      appBar: AppBar(
        title: const Text("Ayuda"),
        backgroundColor: const Color.fromARGB(255, 119, 150, 209),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: content(),
    );
  }

  Widget content() {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Card principal con preguntas
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            elevation: 6,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Center(
                    child: Text(
                      "Preguntas Frecuentes",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "¿Qué animales premite la aplicación?",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Text("Respuesta: Perros y Gatos."),
                  SizedBox(height: 15),
                  Text(
                    "¿Cuantas mascotas puedo tener en la aplicación?",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Text("Respuesta: Por los momentos 5 mascotas."),
                ],
              ),
            ),
          ),

          const SizedBox(height: 30),

          // Sección de contacto
          const Center(
            child: Text(
              "Contact Us!",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 20),

          // Card de redes sociales
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
              side: const BorderSide(color: Colors.black12),
            ),
            color: Colors.grey[200],
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const Text(
                    "Find us and send your questions!",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 15),
                  Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        final uri = Uri.parse('https://instagram.com/itslorenaj');
                        if (await canLaunchUrl(uri)) {
                          await launchUrl(uri, mode: LaunchMode.externalApplication);
                        }
                      },
                      child: Image.asset(
                        'assets/instagram.png',
                        width: 40,
                        height: 40,
                      ),
                    ),
                    const SizedBox(width: 30),
                    GestureDetector(
                      onTap: () async {
                        final uri = Uri.parse('https://www.tiktok.com/@yeslorena');
                        if (await canLaunchUrl(uri)) {
                          await launchUrl(uri, mode: LaunchMode.externalApplication);
                        }
                      },
                      child: Image.asset(
                        'assets/tiktok.png',
                        width: 40,
                        height: 40,
                      ),
                    ),
                  ],
                )

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
