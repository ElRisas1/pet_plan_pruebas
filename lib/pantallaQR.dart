import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PantallaQR extends StatefulWidget {
  final String idMascota;

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
    try {
      final response = await Supabase.instance.client
          .from('mascota') // ← ¡usa el nombre correcto: 'mascota' en minúscula!
          .select()
          .eq('id', idMascota)
          .single();

      return response;
    } catch (e) {
      print('Error cargando mascota: $e');
      return null;
    }
  }

  String generarContenidoQR(Map<String, dynamic> data) {
    return '''
      Nombre: ${data['Nombre'] ?? ''}
      Edad: ${data['Edad'] ?? ''}
      Animal: ${data['Animal'] ?? ''}
      Castrado: ${data['Castrado'] ?? ''}
      Color de pelaje: ${data['Color_pelaje'] ?? ''}
      Raza: ${data['Raza'] ?? ''}
      Chip: ${data['Num_Chip'] ?? ''}
      Veterinario: ${data['Veterinario'] ?? ''}
      Info extra: ${data['Informacion'] ?? ''}
      ''';
  }

  Widget _mostrarCampo(String titulo, dynamic valor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$titulo: ',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Text(
              valor != null && valor.toString().isNotEmpty ? valor.toString() : 'N/D',
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Código QR de la Mascota'),
        backgroundColor: const Color.fromARGB(248, 144, 177, 235),
      ),
      body: FutureBuilder<Map<String, dynamic>?>(
        future: mascotaFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError || !snapshot.hasData || snapshot.data == null) {
            return const Center(
              child: Text(
                'Error al cargar los datos de la mascota.',
                style: TextStyle(color: Colors.red, fontSize: 16),
              ),
            );
          }

          final data = snapshot.data!;
          final qrContent = generarContenidoQR(data);
          final imagenUrl = data['Foto'] ?? '';

          return SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (imagenUrl.isNotEmpty)
                  ClipOval(
                    child: Image.network(
                      imagenUrl,
                      width: 120,
                      height: 120,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => const Icon(Icons.pets, size: 80),
                    ),
                  )
                else
                  const Icon(Icons.pets, size: 80, color: Colors.grey),

                const SizedBox(height: 20),

                QrImageView(
                  data: qrContent,
                  version: QrVersions.auto,
                  size: 250.0,
                ),
                const SizedBox(height: 20),

                _mostrarCampo('Nombre', data['Nombre']),
                _mostrarCampo('Edad', data['Edad']),
                _mostrarCampo('Animal', data['Animal']),
                _mostrarCampo('Raza', data['Raza']),
                _mostrarCampo('Color de pelaje', data['Color_pelaje']),
                _mostrarCampo('Castrado', data['Castrado']),
                _mostrarCampo('Chip', data['Num_Chip']),
                _mostrarCampo('Veterinario', data['Veterinario']),
                _mostrarCampo('Información', data['Informacion']),
              ],
            ),
          );
        },
      ),
    );
  }
}
