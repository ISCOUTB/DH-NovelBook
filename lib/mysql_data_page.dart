// mysql_data_page.dart
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MySQLDataPage extends StatefulWidget {
  const MySQLDataPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MySQLDataPageState createState() => _MySQLDataPageState();
}

class _MySQLDataPageState extends State<MySQLDataPage> {
  List data = [];

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse('http://tu_servidor.com/api.php'));

    if (response.statusCode == 200) {
      setState(() {
        data = json.decode(response.body);
      });
    } else {
      throw Exception('Error al cargar los datos');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Datos de MySQL'),
      ),
      body: data.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(data[index]['titulo']),
                  subtitle: Text(data[index]['autor']),
                );
              },
            ),
    );
  }
}
