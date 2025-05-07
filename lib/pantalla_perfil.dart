import 'package:flutter/material.dart';

   

    // Pantalla de perfil principal
    class PantallaPerfil extends StatelessWidget {
  const PantallaPerfil({super.key});

      @override
      Widget build(BuildContext context) {
        return Scaffold(
          backgroundColor: const Color.fromARGB(248, 152, 184, 239), // Fondo azul claro
          appBar: AppBar(title: Text("Pantallaperfil")),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 20),

                  // Contenedor para la imagen de perfil con borde circular
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2.5),
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        'assets/profile_pic.png',
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),
                  const Text('@perfilprueba1', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const Text('Pedro ', style: TextStyle(fontSize: 20)),
                  const SizedBox(height: 10),

                  // Contenedor para mostrar información adicional
                  Container(
                    padding: const EdgeInsets.all(16),
                    margin: const EdgeInsets.symmetric(horizontal: 40),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text('Prueba de texto', textAlign: TextAlign.center),
                  ),

                  const SizedBox(height: 10),

                  // Botón para mostrar más información (sin funcionalidad por ahora)
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    onPressed: () {},
                    child: const Text('Más Info'),
                  ),

                  const SizedBox(height: 20),
                  PetsSection(), // Sección de mascotas
                  const SizedBox(height: 20),
                  PhotoSection(), // Sección de fotos
                  const SizedBox(height: 20),

                  // Botón para cerrar sesión (sin funcionalidad por ahora)
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    onPressed: () {},
                    child: const Text('Cerrar sesión'),
                  ),
                ],
              ),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
