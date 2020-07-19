import 'package:flutter/material.dart';
import 'package:flutter_peliculas/src/pages/home.page.dart';
import 'package:flutter_peliculas/src/pages/pelicula_detalle.page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Peliculas App',
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        'detalle': (context) => PeliculaDetallePage()
      },
    );
  }
}
