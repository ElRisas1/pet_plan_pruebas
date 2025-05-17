import 'package:flutter/material.dart';
import 'package:pet_plan_pruebas/pantalla_ayuda.dart';
import 'package:pet_plan_pruebas/pantalla_perfil.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PantallaAjustes extends StatefulWidget {
  const PantallaAjustes({super.key, required this.title});
  final String title;

  @override
  _PantallaAjustesState createState() => _PantallaAjustesState();
}

class _PantallaAjustesState extends State<PantallaAjustes> {
  final List<_AjusteItem> opcionesAjustes = [
    _AjusteItem(
      nombre: "Ayuda",
      destino: PantallaAyuda(title: "Ayuda", opcionesAjustes: "Ayuda"),
    ),
    _AjusteItem(
      nombre: "Política de privacidad",
      destino: PantallaPerfil(),
    ),
    _AjusteItem(
      nombre: "Cerrar sesión",
      destino: const SizedBox(), // No se usa, manejado manualmente
    ),
  ];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color.fromARGB(248, 152, 184, 239),
      appBar: AppBar(title: const Text("PetPlan")),
      body: SingleChildScrollView(
        child: SizedBox(
          height: screenHeight * 1.5,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.only(top: screenHeight * 0.03),
                  child: const Text(
                    "Ajustes",
                    style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Positioned(
                top: screenHeight * 0.13,
                left: screenWidth * 0.1,
                right: screenWidth * 0.1,
                child: Container(
                  height: screenHeight * 0.25,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0, 2),
                      )
                    ],
                  ),
                  child: ListView.separated(
                    itemCount: opcionesAjustes.length,
                    separatorBuilder: (context, index) => const Divider(),
                    itemBuilder: (context, index) {
                      final item = opcionesAjustes[index];
                      return ListTile(
                        leading: const Icon(Icons.settings, color: Colors.blueGrey),
                        title: Text(
                          item.nombre,
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 18, color: Colors.grey),
                        onTap: () {
                          if (item.nombre == "Cerrar sesión") {
                            _mostrarDialogoCerrarSesion(context);
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => item.destino),
                            );
                          }
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _mostrarDialogoCerrarSesion(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text("Confirmar"),
          content: const Text("¿Estás seguro de que deseas cerrar sesión?"),
          actions: [
            TextButton(
              child: const Text("Cancelar"),
              onPressed: () => Navigator.of(dialogContext).pop(),
            ),
            TextButton(
              child: const Text("Cerrar sesión", style: TextStyle(color: Colors.red)),
              onPressed: () async {
                Navigator.of(dialogContext).pop();
                await Supabase.instance.client.auth.signOut();
                if (!mounted) return;
                Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
              },
            ),
          ],
        );
      },
    );
  }
}

class _AjusteItem {
  final String nombre;
  final Widget destino;

  _AjusteItem({required this.nombre, required this.destino});
}


