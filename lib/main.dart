import 'package:flutter/material.dart';
import 'login.dart';
import 'menu.dart';
import 'tambah_resep.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Resep App',
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/menu': (context) => MenuScreen(),
        '/tambah-resep': (context) => TambahResepScreen(),
      },
    );
  }
}
