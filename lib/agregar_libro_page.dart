// agregar_libro_page.dart
import 'package:flutter/material.dart';

class AgregarLibroPage extends StatelessWidget {
  const AgregarLibroPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController authorController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar Libro'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Título del Libro',
              style: TextStyle(fontSize: 18),
            ),
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Ingresa el título',
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Autor',
              style: TextStyle(fontSize: 18),
            ),
            TextField(
              controller: authorController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Ingresa el nombre del autor',
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Descripción',
              style: TextStyle(fontSize: 18),
            ),
            TextField(
              controller: descriptionController,
              maxLines: 4,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Ingresa una breve descripción',
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Selecciona una Imagen',
              style: TextStyle(fontSize: 18),
            ),
            // Aquí puedes agregar un botón para seleccionar una imagen
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Lógica para seleccionar una imagen
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
              child: const Text('Elegir Imagen'),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Lógica para guardar el libro
                  // _titleController.text, _authorController.text, _descriptionController.text
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
                child: const Text(
                  'Guardar Libro',
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
