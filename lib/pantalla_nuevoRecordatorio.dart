import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PantallaNuevoRecordatorio extends StatefulWidget {
  final String title;

  const PantallaNuevoRecordatorio({super.key, required this.title});

  @override
  _PantallaNuevoRecordatorioState createState() =>
      _PantallaNuevoRecordatorioState();
}

class _PantallaNuevoRecordatorioState extends State<PantallaNuevoRecordatorio> {
  final TextEditingController motivoController = TextEditingController();
  final TextEditingController mascotaController = TextEditingController();
  DateTime? fechaHoraSeleccionada;

  Future<void> _seleccionarFechaYHora(BuildContext context) async {
    final DateTime? fecha = await showDatePicker(
      context: context,
      initialDate: fechaHoraSeleccionada ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (fecha != null) {
      final TimeOfDay? hora = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(DateTime.now()),
      );

      if (hora != null) {
        setState(() {
          fechaHoraSeleccionada = DateTime(
            fecha.year,
            fecha.month,
            fecha.day,
            hora.hour,
            hora.minute,
          );
        });
      }
    }
  }

  String _formatearFechaHora(DateTime fechaHora) {
    String dia = fechaHora.day.toString().padLeft(2, '0');
    String mes = fechaHora.month.toString().padLeft(2, '0');
    String anio = fechaHora.year.toString();
    String hora = fechaHora.hour.toString().padLeft(2, '0');
    String minuto = fechaHora.minute.toString().padLeft(2, '0');
    return "$dia/$mes/$anio - $hora:$minuto";
  }

  Future<void> _guardarEnSupabase() async {
    final motivo = motivoController.text.trim();
    final mascota = mascotaController.text.trim();
    final fechaHora = fechaHoraSeleccionada;
    final supabase = Supabase.instance.client;
    final user = supabase.auth.currentUser;

    if (motivo.isEmpty || mascota.isEmpty || fechaHora == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Completa todos los campos.")),
      );
      return;
    }

    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Debes iniciar sesión para guardar.")),
      );
      return;
    }

    try {
      await supabase.from('recordatorios').insert({
        'Nombre': motivo,
        'Fecha': fechaHora.toIso8601String(),
        'Notas': mascota,
        'user_id': user.id, // 👈 Campo obligatorio con RLS activado
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Recordatorio guardado con éxito.")),
      );

      Navigator.pop(context);
    } catch (e) {
      print("Error al guardar en Supabase: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error al guardar el recordatorio.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(248, 238, 220, 138),
      appBar: AppBar(title: Text(widget.title)),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: motivoController,
              decoration: InputDecoration(
                labelText: 'Motivo del recordatorio',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () => _seleccionarFechaYHora(context),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  fechaHoraSeleccionada != null
                      ? 'Fecha: ${_formatearFechaHora(fechaHoraSeleccionada!)}'
                      : 'Selecciona fecha y hora',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: mascotaController,
              decoration: InputDecoration(
                labelText: 'Mascota involucrada',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: _guardarEnSupabase,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                padding: EdgeInsets.symmetric(vertical: 16),
              ),
              child: Text('Guardar Recordatorio',
                  style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}

