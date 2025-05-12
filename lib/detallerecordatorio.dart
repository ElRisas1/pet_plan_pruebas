import 'package:flutter/material.dart';

class DetalleRecordatorio extends StatelessWidget {
  final String nombre;
  final String fecha;
  final String nota;
  final String hora;

  const DetalleRecordatorio({
    super.key,
    required this.nombre,
    required this.fecha,
    required this.nota,
    required this.hora,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFA7C4ED),
      body: SafeArea(
        child: Column(
          children: [
            // Encabezado
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, size: 28),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  const Center(
                    child: Text(
                      "Recordatorio",
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),

            // Contenido
            Expanded(
              child: Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [const BoxShadow(color: Colors.black26, blurRadius: 6)],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Time: $hora", style: const TextStyle(fontSize: 16)),
                      const SizedBox(height: 10),
                      Text("Name: $nombre", style: const TextStyle(fontSize: 16)),
                      const SizedBox(height: 10),
                      Text("Date: $fecha", style: const TextStyle(fontSize: 16)),
                      const SizedBox(height: 10),
                      Text(
                        "Note: ${nota.isEmpty ? 'Empty' : nota}",
                        style: TextStyle(
                          fontSize: 16,
                          color: nota.isEmpty ? Colors.grey : Colors.black,
                        ),
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: () {
                          // lógica de edición pendiente
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: const Center(child: Text("Edit", style: TextStyle(fontSize: 16))),
                      ),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        onPressed: () {
                          // lógica de eliminación pendiente
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: const Center(child: Text("Delete", style: TextStyle(fontSize: 16))),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}