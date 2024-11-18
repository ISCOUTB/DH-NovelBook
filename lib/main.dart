// main.dart
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'panel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bienvenido',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  String connectionMessage = 'Presiona el botón para comprobar la conexión';
  final TextEditingController correoController = TextEditingController();
  final TextEditingController contrasenaController = TextEditingController();
  final TextEditingController nombreController = TextEditingController(); // Solo para registro
  final TextEditingController confirmarContrasenaController = TextEditingController(); // Solo para registro

  Future<void> checkConnection() async {
    try {
      final response = await http.get(Uri.parse('http://192.168.1.36/DH-NovelBook/index.php'));

      if (!mounted) return;

      if (response.statusCode == 200) {
        setState(() {
          connectionMessage = response.body; // Muestra la respuesta del servidor
        });
      } else {
        setState(() {
          connectionMessage = 'Error al conectar con el servidor: ${response.statusCode}';
        });
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        connectionMessage = 'Error de conexión: $e';
      });
    }
  }

  Future<void> registrarUsuario() async {
    final response = await http.post(
      Uri.parse('http://192.168.1.36/DH-NovelBook/registro.php'),
      body: {
        'nombre': nombreController.text,
        'correo': correoController.text,
        'contrasena': contrasenaController.text,
      },
    );

    if (!mounted) return;

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['error'] != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(data['error'])));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(data['mensaje'])));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Error al registrar el usuario')));
    }
  }

  Future<void> iniciarSesion() async {
    final response = await http.post(
      Uri.parse('http://192.168.1.36/DH-NovelBook/iniciar_sesion.php'),
      body: {
        'correo': correoController.text,
        'contrasena': contrasenaController.text,
      },
    );

    if (!mounted) return;

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['error'] != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(data['error'])));
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Panel()), // Navega a la página principal
        );
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(data['mensaje'])));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Error al iniciar sesión')));
    }
  }

  void _showDialog(BuildContext context, String title) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (title == 'Registro')
                  TextField(
                    controller: nombreController,
                    decoration: const InputDecoration(labelText: 'Nombre'),
                  ),
                TextField(
                  controller: correoController,
                  decoration: const InputDecoration(labelText: 'Correo electrónico'),
                ),
                TextField(
                  controller: contrasenaController,
                  decoration: const InputDecoration(labelText: 'Contraseña'),
                  obscureText: true,
                ),
                if (title == 'Registro')
                  TextField(
                    controller: confirmarContrasenaController,
                    decoration: const InputDecoration(labelText: 'Confirmar Contraseña'),
                    obscureText: true,
                  ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(title),
              onPressed: () {
                if (title == 'Iniciar sesión') {
                  iniciarSesion();
                } else {
                  if (contrasenaController.text == confirmarContrasenaController.text) {
                    registrarUsuario();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Las contraseñas no coinciden')),
                    );
                  }
                }
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/logo1.jpg'), // Fondo de la pantalla
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(32.0),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.25), // Fondo blanco semi-transparente
                  borderRadius: BorderRadius.circular(16.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26, // Sombra
                      blurRadius: 10.0,
                      offset: Offset(0, 10),
                    ),
                  ],
                ),
                width: 600,
                height: 350,
                child: Row(
                  children: [
                    // Parte izquierda con texto
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            '¡Bienvenido a NovelNook!',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Conéctate, explora, comparte y descubre nuevas historias con otros apasionados por los libros. ¡Tu próxima gran lectura te espera!',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 32),
                    // Parte derecha con botones
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () => _showDialog(context, 'Registro'),
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: const Color(0xFF3182CE),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
                            ),
                          ),
                          child: const Text('Registrarse'),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () => _showDialog(context, 'Iniciar sesión'),
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: const Color(0xFF3182CE),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
                            ),
                          ),
                          child: const Text('Iniciar sesión'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: checkConnection,
                child: const Text('Comprobar Conexión'),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(connectionMessage),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
