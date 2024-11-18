// agregar_libro_page.dart
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart'; // Verifica si la aplicación se ejecuta en la web

class AgregarLibroPage extends StatefulWidget {
  const AgregarLibroPage({super.key});

  @override
  AgregarLibroPageState createState() => AgregarLibroPageState(); // Clase pública
}

class AgregarLibroPageState extends State<AgregarLibroPage> {
  final TextEditingController tituloController = TextEditingController();
  final TextEditingController autorController = TextEditingController();
  final TextEditingController descripcionController = TextEditingController();
  Uint8List? imagenBytes;
  Uint8List? pdfBytes;
  String? imagenNombre;
  String? pdfNombre;

  Future<void> seleccionarArchivo(bool esImagen) async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: esImagen ? FileType.image : FileType.custom,
        allowedExtensions: esImagen ? null : ['pdf'],
      );

      if (result != null) {
        setState(() {
          if (kIsWeb) {
            if (esImagen) {
              imagenBytes = result.files.single.bytes;
              imagenNombre = result.files.single.name;
            } else {
              pdfBytes = result.files.single.bytes;
              pdfNombre = result.files.single.name;
            }
          }
        });

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(esImagen ? 'Imagen seleccionada' : 'PDF seleccionado')),
          );
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('No se seleccionó ningún archivo')),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al seleccionar archivo: $e')),
        );
      }
    }
  }

  Future<void> agregarLibro() async {
    final uri = Uri.parse('http://192.168.1.36/DH-NovelBook/agregar_libro.php');
    var request = http.MultipartRequest('POST', uri);
    request.fields['titulo'] = tituloController.text;
    request.fields['autor'] = autorController.text;
    request.fields['descripcion'] = descripcionController.text;

    if (imagenNombre != null) {
      request.files.add(http.MultipartFile.fromBytes('imagen', imagenBytes!, filename: imagenNombre));
    }
    if (pdfNombre != null) {
      request.files.add(http.MultipartFile.fromBytes('pdf', pdfBytes!, filename: pdfNombre));
    }

    var response = await request.send();
    if (mounted) {
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Libro agregado exitosamente')));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Error al agregar el libro')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar Libro'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: tituloController,
              decoration: const InputDecoration(labelText: 'Título'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: autorController,
              decoration: const InputDecoration(labelText: 'Autor'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: descripcionController,
              decoration: const InputDecoration(labelText: 'Descripción'),
              maxLines: 3,
            ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                ElevatedButton(
                  onPressed: () => seleccionarArchivo(true),
                  child: Text(imagenNombre == null ? 'Seleccionar Imagen' : 'Imagen seleccionada'),
                ),
                ElevatedButton(
                  onPressed: () => seleccionarArchivo(false),
                  child: Text(pdfNombre == null ? 'Seleccionar PDF' : 'PDF seleccionado'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: agregarLibro,
                child: const Text('Agregar Libro'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
