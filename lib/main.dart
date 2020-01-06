import 'package:flutter/material.dart';
import 'package:pokedex_flutter/interfaces/regionList.dart';
import 'utitlities.dart';

void main() => runApp(PokedexApp());

final regions = List<RegionArguements>.generate(
    pokeRegions.length,
    (i) => RegionArguements(pokeRegions[i], pokemondIdsForRegion[i][0],
        pokemondIdsForRegion[i][1], pokemonForRegionsArray[i]));

class PokedexApp extends StatefulWidget {
  PokedexApp({Key key}) : super(key: key);

  @override
  _PokedexAppState createState() => _PokedexAppState();
}

class _PokedexAppState extends State<PokedexApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pokedéx',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: Scaffold(
          appBar: AppBar(
            title: Text('Pokedéx'),
          ),
          body: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: pokeRegions.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(children: <Widget>[
                  buildRow(index, context),
                  Divider(
                    thickness: 1.0,
                  )
                ]);
              })),
    );
  }
}

Widget buildRow(int index, BuildContext context) {
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
