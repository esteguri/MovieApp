import 'package:flutter/material.dart';
import 'package:flutter_peliculas/src/models/pelicula.model.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class CardSwiper extends StatelessWidget {
  final List<Pelicula> lista;

  CardSwiper({@required this.lista});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(top: 20),
      child: Swiper(
        itemBuilder: (context, index) {
          final pelicula = lista[index];
          pelicula.uniqueId = "${pelicula.id}-card";
          return Hero(
            tag: pelicula.uniqueId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, 'detalle', arguments: pelicula);
                },
                child: FadeInImage(
                  placeholder: AssetImage('assets/no-image.jpg'),
                  image: NetworkImage(pelicula.getPosterImg()),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
        itemCount: lista.length,
        layout: SwiperLayout.STACK,
        itemWidth: _screenSize.width * 0.7,
        itemHeight: _screenSize.height * 0.5,
      ),
    );
  }
}
