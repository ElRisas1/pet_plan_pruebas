import 'package:flutter/material.dart';
import 'package:pet_plan_pruebas/pantalla_main.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar()
    );
  }
}

class PantallaPerfil extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[200],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {},
                  ),
                ],
              ),
              const CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/profile_pic.png'),
              ),
              const SizedBox(height: 10),
              const Text('@Chinito', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const Text('Chinardo ', style: TextStyle(fontSize: 20)),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.symmetric(horizontal: 40),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text('Mmmm perlo', textAlign: TextAlign.center),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                onPressed: () {},
                child: const Text('More Info'),
              ),
              const SizedBox(height: 20),
              PetsSection(),
              const SizedBox(height: 20),
              PhotoSection(),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                onPressed: () {},
                child: const Text('Log Off'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PetsSection extends StatelessWidget {
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
          const Text('Your Pets', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              PetCard(name: 'pelusa', image: 'assets/Perro1.png'),
              PetCard(name: 'tomusa', image: 'assets/gatobonito.jpg'),
              AddPetCard(),
            ],
          ),
        ],
      ),
    );
  }
}

class PetCard extends StatelessWidget {
  final String name;
  final String image;

  const PetCard({required this.name, required this.image});

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

class AddPetCard extends StatelessWidget {
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
        const Text('Add new Pet'),
      ],
    );
  }
}

class PhotoSection extends StatelessWidget {
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
              Text('Add a photo'),
            ],
          ),
          const SizedBox(height: 10),
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

