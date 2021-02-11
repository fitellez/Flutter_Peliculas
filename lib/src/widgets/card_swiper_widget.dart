import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:peliculas/src/models/pelicula_model.dart';

class CardSwiper extends StatelessWidget {
  final List<Pelicula> peliculas;

  CardSwiper({@required this.peliculas}); //Se declara como obligatorio

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(
        top: 20.0,
      ),
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          peliculas[index].uniqueId = '${peliculas[index].id}-tarjeta';
          return Column(
            children: <Widget>[
              Text(peliculas[index].originalTitle),
              // Text(peliculas[index].title),
              Hero(
                tag: peliculas[index].uniqueId,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(0.0),
                    child: GestureDetector(
                      onTap: (){
                        Navigator.pushNamed(context, 'detalle', arguments: peliculas[index]);
                      },
                      child: FadeInImage(
                      image: NetworkImage(peliculas[index].getPosterImg()),
                      placeholder: AssetImage('assets/no-image.jpg'),
                      fit: BoxFit.cover,
                    )),
                    )
                    
              ),
            ],
          );
        },
        itemCount: peliculas.length,
        itemWidth: _screenSize.width * 0.7,
        itemHeight: _screenSize.height * 0.6,
        layout: SwiperLayout.STACK,
      ),
    );
  }
}
