// inicio_page.dart
import 'package:flutter/material.dart';

class InicioPage extends StatelessWidget {
  const InicioPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Bienvenido a NovelNook',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              const Text(
                'Explora nuestra colección de libros y encuentra tu próxima lectura.',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 30),

              // Sección de libros destacados
              const Text(
                'Libros Destacados',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 220, // Ajusta la altura según sea necesario
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: const [
                    BookCard(
                      imageUrl: 'assets/images/libro1.jpeg', // Asegúrate de tener estas imágenes
                      title: 'El Nombre del Viento',
                      author: 'Patrick Rothfuss',
                    ),
                    SizedBox(width: 10), // Espaciado entre las tarjetas
                    BookCard(
                      imageUrl: 'assets/images/libro2.jpeg',
                      title: 'Cien Años de Soledad',
                      author: 'Gabriel García Márquez',
                    ),
                    SizedBox(width: 10), // Espaciado entre las tarjetas
                    BookCard(
                      imageUrl: 'assets/images/libro3.jpg',
                      title: '1984',
                      author: 'George Orwell',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Botón para explorar más libros
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Navegar a otra página o realizar otra acción
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  ),
                  child: const Text(
                    'Explorar Más Libros',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BookCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String author;

  const BookCard({
    required this.imageUrl,
    required this.title,
    required this.author,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              imageUrl,
              height: 150, // Ajusta la altura según sea necesario
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            author,
            style: const TextStyle(color: Colors.grey),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
