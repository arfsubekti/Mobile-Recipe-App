import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class TambahResepScreen extends StatefulWidget {
  @override
  _TambahResepScreenState createState() => _TambahResepScreenState();
}

class _TambahResepScreenState extends State<TambahResepScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController ingredientsController = TextEditingController();
  final TextEditingController methodController = TextEditingController();

  Future<void> addRecipe() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final response = await http.post(
      Uri.parse('http://127.0.0.1:8000/api/recipes'),
      headers: {'Authorization': 'Bearer $token'},
      body: {
        'title': titleController.text,
        'description': descriptionController.text,
        'ingredients': ingredientsController.text,
        'cooking_method': methodController.text,
      },
    );

    if (response.statusCode == 201) {
      Navigator.pop(context);
    } else {
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tambah Resep')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Judul Resep'),
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Deskripsi'),
            ),
            TextField(
              controller: ingredientsController,
              decoration: InputDecoration(labelText: 'Bahan-bahan'),
            ),
            TextField(
              controller: methodController,
              decoration: InputDecoration(labelText: 'Cara Memasak'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: addRecipe,
              child: Text('Tambah Resep'),
            ),
          ],
        ),
      ),
    );
  }
}
