import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'pantalla_nuevoRecordatorio.dart';

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
      final data = await supabase.from('recordatorios').select().order('Fecha');

      setState(() {
        recordatorios = List<Map<String, dynamic>>.from(data);
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
      backgroundColor: const Color.fromARGB(248, 152, 184, 239),
      body: Stack(
        children: [
          AppBar(
            title: Text("Recordatorio"),
            backgroundColor: Color.fromARGB(248, 238, 220, 138),
          ),
          Positioned(
            top: 100,
            left: 25,
            right: 25,
            bottom: 100,
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: cargando
                  ? Center(child: CircularProgressIndicator())
                  : recordatorios.isEmpty
                      ? Center(child: Text("No hay recordatorios"))
                      : ListView.builder(
                          itemCount: recordatorios.length,
                          itemBuilder: (context, index) {
                            final rec = recordatorios[index];
                            final fecha = DateTime.tryParse(rec['Fecha'] ?? '') ?? DateTime.now();

                            return Card(
                              margin: EdgeInsets.symmetric(vertical: 8),
                              child: ListTile(
                                title: Text("📌 ${rec['Nombre'] ?? 'Sin nombre'}"),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("📅 ${DateFormat('dd/MM/yyyy – HH:mm').format(fecha)}"),
                                    Text("🐾 Mascota: ${rec['Notas'] ?? 'Sin datos'}"),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
            ),
          ),
          Positioned(
            bottom: 30,
            right: 30,
            child: ElevatedButton(
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PantallaNuevoRecordatorio(title: "Nuevo recordatorio"),
                  ),
                );
                _cargarRecordatorios(); // recarga al volver
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
              child: Text("Crear recordatorio", style: TextStyle(fontSize: 16)),
            ),
          ),
        ],
      ),
    );
  }
}
