// lecturas_page.dart
import 'package:flutter/material.dart';

class LecturasPage extends StatelessWidget {
  const LecturasPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Control de Lectura'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Mis Libros Leídos',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: const [
                  BookProgressCard(
                    title: 'El Nombre del Viento',
                    author: 'Patrick Rothfuss',
                    progress: 75, // Progreso en porcentaje
                    imagePath: 'assets/images/libro1.jpeg', // Ruta de la imagen
                  ),
                  SizedBox(height: 10),
                  BookProgressCard(
                    title: 'Cien Años de Soledad',
                    author: 'Gabriel García Márquez',
                    progress: 50,
                    imagePath: 'assets/images/libro2.jpeg', // Ruta de la imagen
                  ),
                  SizedBox(height: 10),
                  BookProgressCard(
                    title: '1984',
                    author: 'George Orwell',
                    progress: 100, // Marcar como leído
                    imagePath: 'assets/images/libro3.jpg', // Ruta de la imagen
                  ),
                ],
              ),
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Navegar a otra página para agregar más libros
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
                child: const Text(
                  'Agregar Nuevo Libro',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BookProgressCard extends StatelessWidget {
  final String title;
  final String author;
  final int progress; // Progreso en porcentaje (0-100)
  final String imagePath; // Ruta de la imagen del libro

  const BookProgressCard({
    required this.title,
    required this.author,
    required this.progress,
    required this.imagePath,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            // Imagen del libro
            Image.asset(
              imagePath,
              width: 80, // Tamaño de la imagen
              height: 120, // Tamaño de la imagen
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 16),
            // Texto y barra de progreso
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    author,
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 10),
                  LinearProgressIndicator(
                    value: progress / 100, // Progreso como valor entre 0 y 1
                    backgroundColor: Colors.grey[300],
                    color: Colors.blueAccent,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Progreso: $progress%',
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      // Marcar el libro como leído
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    ),
                    child: const Text('Marcar como Leído'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
