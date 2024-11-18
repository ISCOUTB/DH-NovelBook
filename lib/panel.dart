// panel.dart
import 'package:flutter/material.dart';
import 'lecturas_page.dart';
import 'agregar_libro_page.dart' as agregar_libro;
import 'perfil_page.dart';
import 'inicio_page.dart';
import 'buscar_libro_page.dart' as buscar_libro; // Asegúrate de que el nombre coincida con tu archivo

class Panel extends StatelessWidget {
  const Panel({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5, // Número de pestañas
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 60,
                padding: const EdgeInsets.only(right: 16.0),
                child: Image.asset(
                  'assets/images/logo1.jpg',
                  fit: BoxFit.contain,
                ),
              ),
              const Text(
                'NovelNook',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            InicioPage(),
            LecturasPage(),
            agregar_libro.AgregarLibroPage(), // Página de agregar libro
            buscar_libro.BuscarLibroPage(), // Página de buscar libros
            PerfilPage(),
          ],
        ),
        bottomNavigationBar: const TabBar(
          labelColor: Colors.blue,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.transparent,
          tabs: [
            Tab(icon: Icon(Icons.home), text: 'Inicio'),
            Tab(icon: Icon(Icons.book), text: 'Lecturas'),
            Tab(icon: Icon(Icons.add), text: 'Agregar Libro'),
            Tab(icon: Icon(Icons.search), text: 'Buscar Libros'),
            Tab(icon: Icon(Icons.person), text: 'Perfil'),
          ],
        ),
      ),
    );
  }
}
