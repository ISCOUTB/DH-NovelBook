// panel.dart
import 'package:flutter/material.dart';
import 'lecturas_page.dart';  // Importa el archivo de LecturasPage
import 'agregar_libro_page.dart';  // Importa el archivo de AgregarLibroPage
import 'perfil_page.dart';  // Importa el archivo de PerfilPage
import 'inicio_page.dart';  // Importa el archivo de InicioPage

class Panel extends StatelessWidget {
  const Panel({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4, // Número de pestañas
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,  // Centra el logo y el texto
            children: [
              Image.asset(
                'assets/images/logo.jpeg',  // Ruta del logo
                height: 40,  // Tamaño del logo
              ),
              const SizedBox(width: 10),  // Espacio entre el logo y el texto
              const Text(
                'NovelNook',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          bottom: const TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            indicatorColor: Colors.white,
            tabs: [
              Tab(icon: Icon(Icons.home), text: 'Inicio'),
              Tab(icon: Icon(Icons.book), text: 'Lecturas'),
              Tab(icon: Icon(Icons.add), text: 'Agregar Libro'),
              Tab(icon: Icon(Icons.person), text: 'Perfil'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            InicioPage(),
            LecturasPage(),
            AgregarLibroPage(),
            PerfilPage(),
          ],
        ),
      ),
    );
  }
}
