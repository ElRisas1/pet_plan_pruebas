import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PantallaQR extends StatefulWidget {
  final String idMascota; // ID o identificador para buscar la mascota

  const PantallaQR({super.key, required this.idMascota});

  @override
  State<PantallaQR> createState() => _PantallaQRState();
}

class _PantallaQRState extends State<PantallaQR> {
  late Future<Map<String, dynamic>?> mascotaFuture;

  @override
  void initState() {
    super.initState();
    mascotaFuture = cargarDatosMascota(widget.idMascota);
  }

  Future<Map<String, dynamic>?> cargarDatosMascota(String idMascota) async {
    final response = await Supabase.instance.client
        .from('Mascotas')
        .select()
        .eq('id', idMascota)
        .single();

    return response;
  }

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Código QR de la Mascota'),
      ),
      body: FutureBuilder<Map<String, dynamic>?>(
        future: mascotaFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError || !snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('Error al cargar los datos de la mascota.'));
          }

          final data = snapshot.data!;
          final qrContent = generarContenidoQR(data);

          return Center(
            child: QrImageView(
              data: qrContent,
              version: QrVersions.auto,
              size: 250.0,
            ),
          );
        },
      ),
    );
  }
}
