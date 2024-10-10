// panel.dart
import 'package:flutter/material.dart';
import 'lecturas_page.dart';  // Importa el archivo de LecturasPage
import 'agregar_libro_page.dart';  // Importa el archivo de AgregarLibroPage
import 'perfil_page.dart';  // Importa el archivo de PerfilPage
import 'inicio_page.dart';  // Importa el archivo de InicioPage
import 'buscar_libros_page.dart';  // Importa la nueva página

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
            mainAxisAlignment: MainAxisAlignment.start,  // Alinea a la izquierda
            children: [
              Container(
                height: 60,  // Aumenta el tamaño del contenedor
                padding: const EdgeInsets.only(right: 16.0),  // Espacio entre el logo y el texto
                child: Image.asset(
                  'assets/images/logo.jpeg',  // Asegúrate de que sea una imagen de alta resolución
                  fit: BoxFit.contain,  // Mantiene el aspecto de la imagen
                ),
              ),
              const Text(
                'NovelNook',
                style: TextStyle(
                  fontSize: 24,  // Aumenta el tamaño del texto
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
              Tab(icon: Icon(Icons.search), text: 'Buscar Libros'), // Nueva pestaña
              Tab(icon: Icon(Icons.person), text: 'Perfil'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            InicioPage(),
            LecturasPage(),
            AgregarLibroPage(),
            BuscarLibrosPage(), // Nueva página
            PerfilPage(),
          ],
        ),
      ),
    );
  }
}
