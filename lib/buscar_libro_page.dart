// buscar_libro_page.dart
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

class BuscarLibroPage extends StatefulWidget {
  const BuscarLibroPage({super.key});

  @override
  BuscarLibroPageState createState() => BuscarLibroPageState();
}

class BuscarLibroPageState extends State<BuscarLibroPage> {
  List<dynamic> libros = [];
  List<dynamic> librosFiltrados = [];
  bool isLoading = true;
  String errorMessage = '';
  TextEditingController searchController = TextEditingController();
  int currentPage = 0;
  int rowsPerPage = 3; // Mostrar 3 filas por página

  @override
  void initState() {
    super.initState();
    fetchLibros();
  }

  Future<void> fetchLibros() async {
    try {
      final response = await http.get(Uri.parse('http://192.168.1.36/DH-NovelBook/buscar_libros.php'));
      if (response.statusCode == 200) {
        setState(() {
          libros = json.decode(response.body);
          librosFiltrados = libros;
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

  void filtrarLibros(String query) {
    if (query.isEmpty) {
      setState(() {
        librosFiltrados = libros;
      });
    } else {
      setState(() {
        librosFiltrados = libros
            .where((libro) => libro['titulo'].toLowerCase().contains(query.toLowerCase()))
            .toList();
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
    final int totalRows = librosFiltrados.length;
    final int totalPages = (totalRows / rowsPerPage).ceil();
    final int start = currentPage * rowsPerPage;
    final int end = start + rowsPerPage;
    final List currentLibros = librosFiltrados.sublist(
      start,
      end > totalRows ? totalRows : end,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Buscar Libros'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : errorMessage.isNotEmpty
              ? Center(child: Text(errorMessage))
              : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: searchController,
                        decoration: const InputDecoration(
                          labelText: 'Buscar por título',
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) {
                          filtrarLibros(value);
                        },
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          // ignore: deprecated_member_use
                          dataRowHeight: 130, // Ajusta la altura de las filas
                          columns: const [
                            DataColumn(label: Text('ID')),
                            DataColumn(label: Text('Título')),
                            DataColumn(label: Text('Autor')),
                            DataColumn(label: Text('Imagen')),
                            DataColumn(label: Text('Acciones')),
                          ],
                          rows: currentLibros.map((libro) {
                            return DataRow(
                              cells: [
                                DataCell(Text(libro['id'].toString())),
                                DataCell(Text(libro['titulo'])),
                                DataCell(Text(libro['autor'])),
                                DataCell(
                                  libro['imagen'] != null
                                      ? Image.memory(
                                          base64Decode(libro['imagen']),
                                          width: 100,
                                          height: 150,
                                          fit: BoxFit.cover,
                                          errorBuilder: (context, error, stackTrace) {
                                            return const Text('No se pudo cargar la imagen');
                                          },
                                        )
                                      : const Text('Sin imagen'),
                                ),
                                DataCell(
                                  ElevatedButton(
                                    onPressed: () {
                                      abrirPDFEnNavegador('http://192.168.1.36/DH-NovelBook/${libro['pdf']}');
                                    },
                                    child: const Text('Ver PDF'),
                                  ),
                                ),
                              ],
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back),
                          onPressed: currentPage > 0
                              ? () {
                                  setState(() {
                                    currentPage--;
                                  });
                                }
                              : null,
                        ),
                        Text('Página ${currentPage + 1} de $totalPages'),
                        IconButton(
                          icon: const Icon(Icons.arrow_forward),
                          onPressed: currentPage < totalPages - 1
                              ? () {
                                  setState(() {
                                    currentPage++;
                                  });
                                }
                              : null,
                        ),
                      ],
                    ),
                  ],
                ),
    );
  }
}
