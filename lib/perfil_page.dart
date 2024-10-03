import 'package:flutter/material.dart';

class PerfilPage extends StatelessWidget {
  const PerfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Simulación de datos del usuario
    const String nombreUsuario = "Jhonny Stevenson";
    const String emailUsuario = "jstevenson@utb.edu.com";
    const String? fotoPerfilUrl = null; // Cambiar esto a la URL o path de la foto si está disponible
    final List<String> librosLeidos = [
      'Cien años de soledad',
      '1984',
      'El amor en los tiempos del cólera',
      // Agrega más libros aquí
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Información del usuario
            const Text(
              'Información del Usuario',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                // Avatar de perfil
                CircleAvatar(
                  radius: 40,
                  // Si fotoPerfilUrl es null, muestra la imagen predeterminada
                  backgroundImage: fotoPerfilUrl != null
                      ? NetworkImage(fotoPerfilUrl) // Cambia esto si la foto es de assets
                      : const AssetImage('assets/images/prede.jpg') as ImageProvider, // Ruta de la imagen predeterminada
                  backgroundColor: Colors.grey[200], // Color de fondo si no hay imagen
                ),
                const SizedBox(width: 16), // Espacio entre la imagen y el texto
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Nombre: $nombreUsuario', style: TextStyle(fontSize: 18)),
                    Text('Email: $emailUsuario', style: TextStyle(fontSize: 18)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Botón para editar el perfil
            ElevatedButton(
              onPressed: () {
                // Aquí puedes implementar la lógica para editar el perfil
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                textStyle: const TextStyle(fontSize: 18),
              ),
              child: const Text('Editar Perfil'),
            ),
            const SizedBox(height: 30),

            // Libros leídos
            const Text(
              'Libros Leídos',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: librosLeidos.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      title: Text(librosLeidos[index]),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          // Aquí puedes implementar la lógica para eliminar el libro de la lista
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
