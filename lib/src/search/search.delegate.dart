import 'package:flutter/material.dart';
import 'package:flutter_peliculas/src/models/pelicula.model.dart';
import 'package:flutter_peliculas/src/services/peliculas.service.dart';

class DataSearch extends SearchDelegate {
  String selection = "";
  final _peliculasService = PeliculasService();

  final peliculas = [
    "Aquaman",
    "Ironman",
    "Hulk",
    "Thor",
    "Spiderman",
    "Superman",
    "Ironman 2"
  ];
  final peliculasRecientes = ["Spiderman", "Capital America"];

  @override
  List<Widget> buildActions(BuildContext context) {
    // Las acciones de nuestro AppBar
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Icono a la izquierda del AppBar
    return IconButton(
      icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Crea los resultados que se muestran
    return Center(
      child: Container(
        height: 100,
        width: 100,
        color: Colors.red,
        child: Text(selection),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return Container();
    } else {
      return FutureBuilder(
        future: _peliculasService.buscarPelicula(query),
        builder: (context, snap) {
          if (snap.hasData) {
            final List<Pelicula> peliculas = snap.data;
            return ListView(
              children: peliculas.map((pelicula) {
                return ListTile(
                  leading: FadeInImage(
                    placeholder: AssetImage("assets/no-image.jpg"),
                    image: NetworkImage(pelicula.getPosterImg()),
                    width: 50.0,
                    fit: BoxFit.contain,
                  ),
                  title: Text(pelicula.title),
                  subtitle: Text(pelicula.originalTitle),
                  onTap: () {
                    close(context, null);
                    pelicula.uniqueId = "";
                    Navigator.pushNamed(context, 'detalle',
                        arguments: pelicula);
                  },
                );
              }).toList(),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      );
    }
  }
}
