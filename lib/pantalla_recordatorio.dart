import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'pantalla_nuevoRecordatorio.dart';
import 'detalleRecordatorio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class PantallaRecordatorio extends StatefulWidget {
  final String recordatorio;

  const PantallaRecordatorio({super.key, required this.recordatorio});

  @override
  State<PantallaRecordatorio> createState() => _PantallaRecordatorioState();
}

class _PantallaRecordatorioState extends State<PantallaRecordatorio> {
  List<Map<String, dynamic>> recordatorios = [];
  bool cargando = true;

  @override
  void initState() {
    super.initState();
    _cargarRecordatorios();
  }

  Future<void> _cargarRecordatorios() async {
    try {
      final supabase = Supabase.instance.client;
      final user = supabase.auth.currentUser;

      //vamos a cargar los recordatorios tambien desde la parte LOCAL que hemos guardado con el SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      final datos = prefs.getStringList('recordatorios') ?? [];

      if (user == null) {
        setState(() {
          cargando = false;
        });
        return;
      }

      final data = await supabase
          .from('recordatorios')
          .select()
          .eq('user_id', user.id)
          .order('Fecha');

      setState(() {
        //esto carga los recordatorios que saca del supabase de forma Online Lo comento por ahora para probarlos
        recordatorios = List<Map<String, dynamic>>.from(data);

        //El mio lo carga desde los archivos guardados en local
        recordatorios = datos
        .map((e) => jsonDecode(e) as Map<String, dynamic>)
        .toList();

        cargando = false;
      });
    } catch (e) {
      print("Error cargando recordatorios: $e");
      setState(() {
        cargando = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF98B8EF),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'Recordatorios',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [BoxShadow(blurRadius: 5, color: Colors.black26)],
                ),
                child: cargando
                    ? const Center(child: CircularProgressIndicator())
                    : recordatorios.isEmpty
                        ? const Center(child: Text("No hay recordatorios"))
                        : ListView.builder(
                            itemCount: recordatorios.length,
                            itemBuilder: (context, index) {
                              final rec = recordatorios[index];
                              final fechaDateTime = DateTime.tryParse(rec['Fecha'] ?? '') ?? DateTime.now();

                              return Card(
                                margin: const EdgeInsets.symmetric(vertical: 8),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                child: ListTile(
                                  title: Text("📌 ${rec['Nombre'] ?? 'Sin nombre'}"),
                                  subtitle: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("📅 ${DateFormat('dd/MM/yyyy – HH:mm').format(fechaDateTime)}"),
                                      Text("🐾 Mascota: ${rec['Notas'] ?? 'Sin datos'}"),
                                    ],
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DetalleRecordatorio(
                                          id: rec['Id_recor'], 
                                          nombre: rec['Nombre'] ?? '',
                                          fecha: DateFormat('dd/MM/yyyy').format(fechaDateTime),
                                          hora: DateFormat('HH:mm').format(fechaDateTime),
                                          nota: rec['Notas'] ?? '',
                                        ),
                                      ),
                                    ).then((eliminado) {
                                      if (eliminado == true) {
                                        _cargarRecordatorios();
                                      }
                                    });
                                  },
                                ),
                              );
                            },
                          ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PantallaNuevoRecordatorio(title: "Nuevo recordatorio"),
                  ),
                );
                _cargarRecordatorios();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              ),
              child: const Text("Crear recordatorio", style: TextStyle(fontSize: 16)),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
