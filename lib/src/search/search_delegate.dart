import 'package:flutter/material.dart';
import 'package:peliculas/src/models/pelicula_model.dart';
import 'package:peliculas/src/providers/peliculas_provider.dart';

class DataSearch extends SearchDelegate{

  final peliculasProvider = new PeliculasProvider();
  final peliculas =[
    '1','2','3', '4', '5'
  ];

  final peliculasRecientes = [
    'Spiderman',
    'Capitan'
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    // Las acciones del appBar
    return [
      IconButton(
        icon: Icon(Icons.clear), 
        onPressed: (){
          query = '';
        }
        )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Icono a la izquierda del appbar
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: (){
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Crea los resultados que se van a mostrar
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Son las sugerencias que aparecen cuando la persona escribe

    // final listaSugerida = ( query.isEmpty ) 
    //     ? peliculasRecientes 
    //     : peliculas.where( (p) => p.toLowerCase().startsWith(query.toLowerCase())).toList();
    // return ListView.builder(
    //   itemCount: listaSugerida.length,
    //   itemBuilder: (BuildContext context, int index) {
    //   return ListTile(
    //     leading: Icon(Icons.movie),
    //     title: Text( listaSugerida[index] ),
    //   );
    //  },
    // );

    if( query.isEmpty ){
      return Container();
    }

    return FutureBuilder(
      future: peliculasProvider.buscarPelicula(query),
      builder: (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot) {
        if( snapshot.hasData ){
          return ListView(
            children: snapshot.data.map( (pelicula){
              return ListTile(
                leading: FadeInImage(
                  image: NetworkImage( pelicula.getPosterImg()),
                  placeholder: AssetImage('assets/no-image.jpg'),
                  width: 50.0,
                  fit: BoxFit.contain,
                ),
                title: Text( pelicula.title ),
                subtitle: Text( pelicula.originalTitle ),
                onTap: (){
                  close(context, null);
                  pelicula.uniqueId = '';
                  Navigator.pushNamed(context, 'detalle', arguments: pelicula);
                },
              );
            }).toList(),
          );
        } else{
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }


}