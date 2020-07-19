import 'package:flutter/material.dart';
import 'package:flutter_peliculas/src/models/pelicula.model.dart';
import 'package:flutter_peliculas/src/search/search.delegate.dart';
import 'package:flutter_peliculas/src/services/peliculas.service.dart';
import 'package:flutter_peliculas/src/widgets/card_swiper.widget.dart';
import 'package:flutter_peliculas/src/widgets/movie_horizontal.widget.dart';

class HomePage extends StatelessWidget {
  final _peliculasService = PeliculasService();

  @override
  Widget build(BuildContext context) {
    _peliculasService.getPopulares();

    return Scaffold(
        appBar: AppBar(
          title: Text("Peliculas"),
          backgroundColor: Colors.red[400],
          centerTitle: false,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(context: context, delegate: DataSearch());
              },
            ),
          ],
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _swiperTarjetas(),
              _footer(context),
            ],
          ),
        ));
  }

  Widget _swiperTarjetas() {
    return FutureBuilder(
      future: _peliculasService.getEnCines(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return CardSwiper(
            lista: snapshot.data,
          );
        } else {
          return Container(
            height: 400.0,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }

  Widget _footer(context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 20.0),
            child:
                Text("Populares", style: Theme.of(context).textTheme.headline5),
          ),
          SizedBox(height: 10.0),
          StreamBuilder(
            stream: _peliculasService.popularesStream,
            builder: (context, snap) {
              if (snap.hasData) {
                return MovieHorizontal(
                  peliculas: snap.data,
                  siguientePagina: _peliculasService.getPopulares,
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          )
        ],
      ),
    );
  }
}
