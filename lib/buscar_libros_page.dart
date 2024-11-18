// buscar_libros_page.dart
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BuscarLibroPage extends StatefulWidget {
  const BuscarLibroPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BuscarLibroPageState createState() => _BuscarLibroPageState();
}

class _BuscarLibroPageState extends State<BuscarLibroPage> {
  final TextEditingController _searchController = TextEditingController();
  List _libros = [];

  Future<void> buscarLibro(String termino) async {
    final response = await http.get(Uri.parse('http://192.168.1.36/DH-NovelBook/buscar_libro.php?termino=$termino'));

    if (response.statusCode == 200) {
      setState(() {
        _libros = json.decode(response.body);
      });
    } else {
      setState(() {
        _libros = [];
      });
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error al buscar libros')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buscar Libro'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                labelText: 'Buscar por título o autor',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  buscarLibro(value);
                }
              },
            ),
            const SizedBox(height: 16),
            Expanded(
              child: _libros.isEmpty
                  ? const Center(child: Text('No se encontraron resultados'))
                  : ListView.builder(
                      itemCount: _libros.length,
                      itemBuilder: (context, index) {
                        final libro = _libros[index];
                        return Card(
                          elevation: 4,
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: ListTile(
                            leading: libro['imagen'] != null && libro['imagen'].isNotEmpty
                                ? Image.network(
                                    'data:image/jpeg;base64,${libro['imagen']}',
                                    width: 100, // Ajusta el ancho
                                    height: 150, // Ajusta la altura para que sea más alta
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return const Icon(Icons.broken_image, size: 50);
                                    },
                                  )
                                : const Icon(Icons.image_not_supported, size: 50),
                            title: Text(libro['titulo']),
                            subtitle: Text(libro['autor']),
                            onTap: () {
                              // Lógica para ver más detalles o abrir el PDF
                            },
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
