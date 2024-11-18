// inicio_page.dart
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
// ignore: unused_import
import 'dart:typed_data';
import 'package:url_launcher/url_launcher.dart';

class InicioPage extends StatefulWidget {
  const InicioPage({super.key});

  @override
  InicioPageState createState() => InicioPageState();
}

class InicioPageState extends State<InicioPage> {
  List<dynamic> librosDestacados = [];
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchLibrosDestacados();
  }

  Future<void> fetchLibrosDestacados() async {
    try {
      final response = await http.get(Uri.parse('http://192.168.1.36/DH-NovelBook/buscar_libros.php'));
      if (response.statusCode == 200) {
        setState(() {
          librosDestacados = json.decode(response.body).take(3).toList(); // Mostrar solo los primeros 3 libros
          isLoading = false;
        });
      } else {
        setState(() {
          errorMessage = 'Error al cargar los libros: ${response.statusCode}';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error de conexión: $e';
        isLoading = false;
      });
    }
  }

  Future<void> abrirPDFEnNavegador(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'No se pudo abrir $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bienvenido a NovelNook'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : errorMessage.isNotEmpty
                ? Center(child: Text(errorMessage))
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Libros Destacados',
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),
                      librosDestacados.isEmpty
                          ? const Center(child: Text('No hay libros destacados disponibles'))
                          : SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: librosDestacados.map((libro) {
                                  return MouseRegion(
                                    cursor: SystemMouseCursors.click,
                                    child: GestureDetector(
                                      onTap: () {
                                        if (libro['pdf'] != null && libro['pdf'].isNotEmpty) {
                                          abrirPDFEnNavegador('http://192.168.1.36/DH-NovelBook/${libro['pdf']}');
                                        } else {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(content: Text('PDF no disponible')),
                                          );
                                        }
                                      },
                                      child: Card(
                                        margin: const EdgeInsets.symmetric(horizontal: 8.0),
                                        child: SizedBox(
                                          width: 150,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              libro['imagen'] != null
                                                  ? Image.memory(
                                                      base64Decode(libro['imagen']),
                                                      width: 150,
                                                      height: 200,
                                                      fit: BoxFit.cover,
                                                      errorBuilder: (context, error, stackTrace) {
                                                        return Container(
                                                          color: Colors.grey[300],
                                                          height: 200,
                                                          width: 150,
                                                          child: const Center(
                                                            child: Text('Imagen no disponible'),
                                                          ),
                                                        );
                                                      },
                                                    )
                                                  : Container(
                                                      color: Colors.grey[300],
                                                      height: 200,
                                                      width: 150,
                                                      child: const Center(
                                                        child: Text('Sin imagen'),
                                                      ),
                                                    ),
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Text(
                                                  libro['titulo'] ?? 'Título desconocido',
                                                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                child: Text(
                                                  libro['autor'] ?? 'Autor desconocido',
                                                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                      const SizedBox(height: 20),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            // Agregar la navegación para explorar más libros si es necesario
                          },
                          child: const Text('Explorar Más Libros'),
                        ),
                      ),
                    ],
                  ),
      ),
    );
  }
}
