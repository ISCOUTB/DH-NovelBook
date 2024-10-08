// buscar_libros_page.dart
import 'package:flutter/material.dart';

class BuscarLibrosPage extends StatelessWidget {
  const BuscarLibrosPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();
    
    // Simulación de una lista de libros con imágenes
    final List<Map<String, String>> libros = [
      {
        'title': 'Cien años de soledad',
        'author': 'Gabriel García Márquez',
        'imagePath': 'assets/images/libro2.jpeg'
      },
      {
        'title': '1984',
        'author': 'George Orwell',
        'imagePath': 'assets/images/libro3.jpg'
      },
      {
        'title': 'El amor en los tiempos del cólera',
        'author': 'Gabriel García Márquez',
        'imagePath': 'assets/images/libro4.jpg'
      },
      {
        'title': 'La casa de los espíritus',
        'author': 'Isabel Allende',
        'imagePath': 'assets/images/libro5.jpg'
      },
      {
        'title': 'El túnel',
        'author': 'Ernesto Sabato',
        'imagePath': 'assets/images/libro6.png'
      },
      // Agrega más libros aquí
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Buscar Libros'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Ingresa el título o autor:',
              style: TextStyle(fontSize: 18),
            ),
            TextField(
              controller: searchController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Buscar...',
              ),
              onChanged: (value) {
                // Aquí puedes implementar la lógica de búsqueda en tiempo real si lo deseas
              },
            ),
            const SizedBox(height: 20),
            const Text(
              'Resultados de búsqueda:',
              style: TextStyle(fontSize: 18),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: libros.length, // Cambia esto según el número de resultados de búsqueda
                itemBuilder: (context, index) {
                  final libro = libros[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: Image.asset(
                        libro['imagePath'] ?? 'assets/images/default_book.jpg', // Imagen del libro
                        width: 50,
                        height: 70,
                        fit: BoxFit.cover,
                      ),
                      title: Text(libro['title'] ?? 'Título no disponible'),
                      subtitle: Text(libro['author'] ?? 'Autor no disponible'),
                      trailing: IconButton(
                        icon: const Icon(Icons.bookmark),
                        onPressed: () {
                          // Aquí puedes implementar la lógica para marcar el libro
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
