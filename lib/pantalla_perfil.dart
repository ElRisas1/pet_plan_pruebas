import 'package:flutter/material.dart';
//Pantallas
import 'package:pet_plan_pruebas/pantalla_ajustes.dart';
import 'package:pet_plan_pruebas/pantalla_edit_perfilUsu.dart';
class PantallaPerfil extends StatelessWidget {

  const PantallaPerfil({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color.fromARGB(248, 152, 184, 239),
      appBar: AppBar(title: const Text("nombre del usuario")),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView( // Hace la pantalla Scrolleable
              child: Column(
                children: [

                  const SizedBox(height: 50), //caja de la foto de perfil

                  // Imagen de perfil
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(shape: BoxShape.circle),
                    child: ClipOval(
                      child: Image.asset(
                        'assets/profile_pic.png',
                        width: 140,
                        height: 140,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  // Cajas de info del perfil
                  const SizedBox(height: 10),
                  const Text('@perfilprueba1', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const Text('Pedro ', style: TextStyle(fontSize: 20)),
                  const SizedBox(height: 20),

                  // Card para informacion del usuario
                  Center(
                    child: FractionallySizedBox(
                      widthFactor: 0.8,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        color: Colors.white,
                        child: const Padding(
                          padding: EdgeInsets.all(16),
                          child: Text(
                            'Prueba de texto ',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Caja para boton de más informacion
                  const SizedBox(height: 15),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    onPressed: () {},
                    child: const Text('Más Información'),
                  ),
                   // Caja para masotas
                  const SizedBox(height: 35),
                  PetsSection(),
                   // Caja para album de fotos
                  const SizedBox(height: 20),
                  PhotoSection(),
                   // Caja para boton de cerrar sesion
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    onPressed: () {},
                    child: const Text('Cerrar sesión'),
                  ),
                ],
              ),
            ),

            // Botón de edición (flotando encima con Positioned)
            Positioned(
              top: screenHeight * 0.05,
              right: screenWidth * 0.05,
              child: const EditarPerfil(),
            ),
          ],
        ),
      ),
    );
  }
}

// Sección para mostrar las mascotas
class PetsSection extends StatelessWidget {
      
  const PetsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          const Text('Tus mascotas', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),

          // Fila para mostrar mascotas y añadir una nueva
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              PetCard(name: 'pelusa', image: 'assets/Perro1.png'),
              PetCard(name: 'tomusa', image: 'assets/gatobonito.jpg'),
              AddPetCard(), // Tarjeta para añadir una nueva mascota
            ],
          ),
        ],
      ),
    );
  }
}

// Componente para mostrar información de una mascota
class PetCard extends StatelessWidget {
  final String name;
  final String image;

  const PetCard({super.key, required this.name, required this.image});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundImage: AssetImage(image),
        ),
        const SizedBox(height: 5),
        Text(name),
      ],
    );
  }
}

// Tarjeta para añadir una nueva mascota
class AddPetCard extends StatelessWidget {

  const AddPetCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: Colors.blue[100],
          child: const Icon(Icons.add, color: Colors.green, size: 30),
        ),
        const SizedBox(height: 5),
        const Text('Añade una mascota'),
      ],
    );
  }
}

//Botón de Edición del perfil
class EditarPerfil extends StatelessWidget {
  const EditarPerfil({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      shape: const CircleBorder(),
      elevation: 5,
      child: IconButton(
        icon: const Icon(Icons.edit, size: 40, color: Colors.blueGrey),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const PantallaEditPerfilUsu(title: ''),
            ),
          );
        },
      ),
    );
  }
}

// Sección para mostrar y añadir fotos
class PhotoSection extends StatelessWidget {

  const PhotoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
    
        children: [
          Row(
            children: const [
              Icon(Icons.add_a_photo, color: Colors.blue),
              SizedBox(width: 10),
              Text('Añade una foto'),
            ],
          ),
          const SizedBox(height: 10),

          // Fila para mostrar imágenes
          Row(
            children: [
              Image.asset('assets/Hamster.png', width: 80, height: 80, fit: BoxFit.cover),
              const SizedBox(width: 10),
              Image.asset('assets/images.png', width: 80, height: 80, fit: BoxFit.cover),
              const SizedBox(width: 10),
              Image.asset('assets/GatoEgipcio.png', width: 80, height: 80, fit: BoxFit.cover),
            ],
          ),
        ],
      ),
    );
  }
}
