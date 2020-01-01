import 'package:flutter/material.dart';
import 'package:pokedex_flutter/views/regionList.dart';
import 'models/pokemon.dart';
import 'dart:async';

void main() => runApp(PokedexApp());

const List<String> pokeRegions = [
  'Kanto',
  'Johto',
  'Hoenn',
  'Sinnoh',
  'Unova',
  'Kalos',
  'Alola'
];

const pokemondIdsForRegion = [
  [1, 151],
  [152, 251],
  [252, 386],
  [387, 494],
  [495, 649],
  [650, 721],
  [722, 807]
];

final regions = List<RegionArguements>.generate(
    pokeRegions.length,
    (i) => RegionArguements(pokeRegions[i], pokemondIdsForRegion[i][0],
        pokemondIdsForRegion[i][1]));

class PokedexApp extends StatefulWidget {
  PokedexApp({Key key}) : super(key: key);

  @override
  _PokedexAppState createState() => _PokedexAppState();
}

class _PokedexAppState extends State<PokedexApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokedex',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: Scaffold(
          appBar: AppBar(
            title: Text('Pokedex'),
          ),
          body: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: pokeRegions.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(children: <Widget>[
                  _buildRow(index, context),
                  Divider(
                    thickness: 1.0,
                  )
                ]);
              })),
    );
  }
}

Widget _buildRow(int index, BuildContext context) {
  return ListTile(
    title: Text(
      pokeRegions[index],
      style: TextStyle(
        fontSize: 20.0, // insert your font size here
      ),
      textAlign: TextAlign.center,
    ),
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => RegionList(region: regions[index])),
      );
    },
  );
}
