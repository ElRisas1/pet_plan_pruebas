import 'package:flutter/material.dart';
import 'package:pet_plan_pruebas/pantallaQR.dart';

class PantallaMascota extends StatefulWidget {

  // VARIABLES //
  final String nombreMascota;
  final String imagenMascota;

  //lista de recordatorios de prueba
 final List<String> recordatorios;


  // Constructor
  const PantallaMascota({super.key, required this.nombreMascota, required this.imagenMascota, required this.recordatorios, // ✅ Se pasa como parámetro
  });
  @override
  _PantallaMascotaState createState() => _PantallaMascotaState();
}

class _PantallaMascotaState extends State<PantallaMascota> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(248, 144, 177, 235),
      body: contenido(),
    );
  }

  Widget contenido(){
    return Stack(
      children: [
        // Appbar
        AppBar(title: Text(widget.nombreMascota),),

        // TITULO DE LA PANTALLA
        Padding(
          padding: const EdgeInsets.only(top: 90, left: 170 ), // esto ajusta el espacio superior para evitar que se solape con el AppBar
          child: Text(
                widget.nombreMascota,
                style: const TextStyle(
                  fontSize: 30,
                  color: Color.fromARGB(218, 0, 0, 0),
                  fontWeight: FontWeight.bold,
                ),
              ),
        ),
      
       // IMAGEN DE PERFIL MASCOTA - CENTRADA
        Positioned(
            top: 150, left: 160, 
            child: Material(
              elevation: 8, 
              shape: const CircleBorder(), 
              clipBehavior: Clip.antiAlias, 

              child: Container(
                padding: const EdgeInsets.all(4), // Espaciado para el borde
                decoration: BoxDecoration(
                  shape: BoxShape.circle, // Hace que el borde sea redondo
                  border: Border.all(color: Colors.white, width: 2.5), // Borde blanco
                ),
                child: InkWell(
                  splashColor: Colors.black26, // Efecto al tocar
                  // onTap
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage(widget.imagenMascota), // pone la imagen correspondiente
                  ),
                  ),
                ),
              ),
        ),

        // TITULO INFORMACIÓN //
        Padding(
          padding: const EdgeInsets.only(top: 300, left: 51),
          child: Text(
            "Información de ${widget.nombreMascota}",
            style: const TextStyle(
              fontSize: 30,
              color: Color.fromARGB(218, 0, 0, 0),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

       // CAJA DE INFORMACIÓN DE LA MASCOTA //
        Positioned(
          top: 350, left: 20, right: 20, // Ajusta la posición
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 6,
                  offset: Offset(0, 3),
                )
              ],
            ),
            child: Text(
              "Aquí irá la información de ${widget.nombreMascota}", // Ejemplo de contenido
              style: TextStyle(fontSize: 18),
            ),
          ),
        ),

        // BOTON QR //
        Positioned(
            top: 445, left: 100, right: 100,
            //boton
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PantallaQR(title: "pantalla qr", nombreMascota: '',)),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent, // Color del botón
                foregroundColor: Colors.white, // Color del texto
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // Bordes redondeados
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 45, 
                  vertical: 20), // Tamaño del botón
                elevation: 8, // Sombra para el botón
              ),
              child: const Text(
                "QR",
                style: TextStyle(
                  fontSize: 20, 
                  fontWeight: FontWeight.bold),
              ),
            ),
          ),

          // TITULO RECORDATORIOS //
          Padding(
            padding: const EdgeInsets.only(top: 520, left: 115 ), // Ajusta el espacio superior para evitar que se solape con el AppBar
            child: const Text(
              "Recordatorios", 
              style: TextStyle(
                fontSize: 28,
                color: Color.fromARGB(218, 0, 0, 0),
                fontWeight: FontWeight.bold, // Puedes cambiar el peso para que se vea más destacado
              ),
            ),
          ),  

          // LISTA DE RECORDATORIOS //
          Positioned(
            top: 580, left: 49, right: 49,
            child: Container(
              height: 200,
              width: 300,
              decoration: BoxDecoration(
                color: Colors.white, //fondo blanco de la lista
                borderRadius: BorderRadius.circular(10), //bordes redondeados
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0, 2),
                  )
                ]
              ),
              child: ListView.builder(
                itemCount: widget.recordatorios.length,
                itemBuilder:(context, index) {
                  return ListTile(
                    title: Text(widget.recordatorios[index]),
                  );
                },
              ),
            ),
          ),
      ],
    );
  }
}
