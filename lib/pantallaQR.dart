import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PantallaQR extends StatefulWidget {

  // VARIABLES //
  final String nombreMascota;

  // Constructor
  const PantallaQR({super.key,  required this.nombreMascota});

  @override
  _PantallaQRState createState() => _PantallaQRState();
}

class _PantallaQRState extends State<PantallaQR> {

  String generarContenidoQR(Map<String, dynamic> data) {
    return '''
      Nombre: ${data['nombre']}
      Tipo: ${data['tipo']}
      Nacimiento: ${data['fecha_nacimiento']}
      Chip: ${data['chip']}
      Color de pelo: ${data['color_pelo']}
      Raza: ${data['raza']}
      Info extra: ${data['info_extra']}
      Veterinario: ${data['veterinario']}
    ''';
  }


   @override
  Widget build(BuildContext context) {

    //final String dataQR = generarQr();

    return Scaffold(
      backgroundColor: const Color.fromARGB(248, 238, 220, 138),
      appBar: AppBar(title: Text("QR Mascota")),
      body: Center(
        child: Column(
          children: [

          ],
        ),
      ),
    );
  }
}
  