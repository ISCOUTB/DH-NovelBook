// agregar_libro_page.dart
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class AgregarLibroPage extends StatefulWidget {
  const AgregarLibroPage({super.key});

  @override
  _AgregarLibroPageState createState() => _AgregarLibroPageState();
}

class _AgregarLibroPageState extends State<AgregarLibroPage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController authorController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  
  String? selectedImage;
  String? selectedPdf;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar Libro'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Padding(
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
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async {
                  FilePickerResult? result = await FilePicker.platform.pickFiles(
                    type: FileType.image,
                  );
                  if (result != null) {
                    setState(() {
                      selectedImage = result.files.single.name;
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
                child: const Text('Elegir Imagen'),
              ),
              if (selectedImage != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text('Imagen seleccionada: $selectedImage'),
                ),
              const SizedBox(height: 16),
              const Text(
                'Selecciona el PDF del Libro',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async {
                  FilePickerResult? result = await FilePicker.platform.pickFiles(
                    type: FileType.custom,
                    allowedExtensions: ['pdf'],
                  );
                  if (result != null) {
                    setState(() {
                      selectedPdf = result.files.single.name;
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
                child: const Text('Elegir PDF'),
              ),
              if (selectedPdf != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text('PDF seleccionado: $selectedPdf'),
                ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Lógica para guardar el libro
                    // titleController.text, authorController.text, descriptionController.text, selectedImage, selectedPdf
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
      ),
    );
  }
}
