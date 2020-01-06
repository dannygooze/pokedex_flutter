import 'package:flutter/material.dart';
import 'package:pokedex_flutter/interfaces/pokemonDetail.dart';

import '../utitlities.dart';

class RegionList extends StatelessWidget {
  final RegionArguements region;

  RegionList({Key key, @required this.region}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(region.name),
        ),
        body: buildPokemonList(
            region.pokemon, region.upperLimit, region.lowerLimit));
  }
}

Widget buildPokemonList(List pokemonList, int upperLimit, int lowerLimit) {
  return ListView.builder(
    padding: const EdgeInsets.all(8),
    itemCount: pokemonList.length,
    itemBuilder: (BuildContext context, int index) {
      return Column(
        children: <Widget>[
          ListTile(
            title: Row(
              children: <Widget>[
                Text(
                  capitalize(pokemonList[index]),
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                  textAlign: TextAlign.left,
                ),
                Image.network(
                  "$spriteUrlPrefix${lowerLimit + index}$spriteUrlSuffix",
                  height: 40,
                  width: 40,
                )
              ],
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PokemonDetail(
                            pokemonId: lowerLimit + index,
                          )));
            },
          ),
          Divider(
            thickness: 1.0,
          )
        ],
      );
    },
  );
}

class RegionArguements {
  final String name;
  final int lowerLimit;
  final int upperLimit;
  final List pokemon;

  RegionArguements(this.name, this.lowerLimit, this.upperLimit, this.pokemon);
}

//This buildList takes a little too long to load, but it generates everything from the API.
//Refactored to use constants that have names hard coded to make the list super fast to load
// Widget buildList(int upperLimit, int lowerLImit) {
//   return FutureBuilder(
//     future: getPokemonByRegion(upperLimit, lowerLImit),
//     builder: (context, pokeFetch) {
//       if (pokeFetch.hasData) {
//         return ListView.builder(
//           itemCount: pokeFetch.data.length,
//           itemBuilder: (context, index) {
//             Pokemon pokemon = pokeFetch.data[index];
//             return Column(
//               children: <Widget>[
//                 buildPokemonRow(pokemon),
//                 Divider(
//                   thickness: 1.0,
//                 )
//               ],
//             );
//           },
//         );
//       } else {
//         return Center(child: CircularProgressIndicator());
//       }
//     },
//   );
// }
