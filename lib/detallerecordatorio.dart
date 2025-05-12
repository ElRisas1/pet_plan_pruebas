import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DetalleRecordatorio extends StatelessWidget {
  final String id;
  final String nombre;
  final String fecha;
  final String hora;
  final String nota;

  const DetalleRecordatorio({
    super.key,
    required this.id,
    required this.nombre,
    required this.fecha,
    required this.hora,
    required this.nota,
  });

  Future<void> _eliminarRecordatorio(BuildContext context) async {
    try {
      final supabase = Supabase.instance.client;

      await supabase
          .from('recordatorios')
          .delete()
          .eq('Id_recor', id);

      Navigator.pop(context, true);
    } catch (e) {
      print("Error eliminando recordatorio: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Error al eliminar el recordatorio")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = const TextStyle(fontSize: 16, fontWeight: FontWeight.w500);
    final labelStyle = const TextStyle(fontSize: 16, color: Colors.black54);

    return Scaffold(
      backgroundColor: const Color(0xFFBFD7F0), // fondo azul claro
      body: SafeArea(
        child: Center(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            padding: const EdgeInsets.all(25),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Icono de volver y título centrado
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.arrow_back, size: 28),
                    ),
                    const Expanded(
                      child: Center(
                        child: Text(
                          "Reminder",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 28), // espacio para equilibrar visualmente
                  ],
                ),
                const SizedBox(height: 20),
                _buildInfoRow("Time:", hora, textStyle, labelStyle),
                _buildInfoRow("Name:", nombre, textStyle, labelStyle),
                _buildInfoRow("Date:", fecha, textStyle, labelStyle),
                _buildInfoRow("Note:", nota.isNotEmpty ? nota : "Empty", textStyle, labelStyle),
                const SizedBox(height: 30),
                _buildButton(
                  context,
                  text: "Edit",
                  color: Colors.green[700]!,
                  onPressed: () {
                    // Puedes enlazar a pantalla de edición si la tienes
                  },
                ),
                const SizedBox(height: 12),
                _buildButton(
                  context,
                  text: "Delete",
                  color: Colors.red[400]!,
                  onPressed: () => _eliminarRecordatorio(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, TextStyle valueStyle, TextStyle labelStyle) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: labelStyle),
          const SizedBox(width: 6),
          Expanded(child: Text(value, style: valueStyle)),
        ],
      ),
    );
  }

  Widget _buildButton(BuildContext context, {
    required String text,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.symmetric(vertical: 14),
        ),
        child: Text(text, style: const TextStyle(fontSize: 16)),
      ),
    );
  }
}
