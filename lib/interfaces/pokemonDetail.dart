import 'package:flutter/material.dart';
import 'package:pokedex_flutter/models/pokeEvolutionChain.dart';
import 'package:pokedex_flutter/models/pokemon.dart';
import 'package:pokedex_flutter/models/pokemonSpecies.dart';

import '../utitlities.dart';

class PokemonDetail extends StatefulWidget {
  final int pokemonId;

  PokemonDetail({Key key, @required this.pokemonId}) : super(key: key);

  @override
  State<PokemonDetail> createState() {
    return PokemonDetailState(pokemonId: pokemonId);
  }
}

class PokemonDetailState extends State<PokemonDetail> {
  final int pokemonId;
  var pokemon;
  var species;
  var evoChain;
  var evoChainLoaded;

  PokemonDetailState({Key key, @required this.pokemonId});

  void initState() {
    super.initState();
    fetchPokemon(pokemonId).then((resp) => {
          setState(() => {pokemon = resp})
        });
    fetchPokemonSpecies(pokemonId).then((resp) => {
          setState(() => {species = resp})
        });

    try {
      fetchPokeEvoChain("${species.evolutionChain.url}").then((resp) => {
            setState(() => {evoChain = resp})
          });
    } catch (e) {
      print(e);
      setState(() => {evoChainLoaded = true});
    }
  }

  @override
  Widget build(BuildContext context) {
    if (pokemon is Pokemon && species is PokemonSpecies && evoChainLoaded) {
      return Scaffold(
          appBar: AppBar(
            title: Text(capitalize(pokemon.name)),
          ),
          body: Align(
              alignment: Alignment.topCenter,
              child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          "assets/images/${pokemon.types[pokemon.types.length - 1].type.name}$spriteUrlSuffix"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Column(children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Center(
                        child: Image.network(
                            "$artUrlPrefix$pokemonId$spriteUrlSuffix"),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Text(
                        "${capitalize(pokemon.name)}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: MediaQuery.of(context).size.height / 25,
                            color: Colors.white),
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: Container(
                        padding: EdgeInsets.all(20),
                        height: MediaQuery.of(context).size.height / 2,
                        width: MediaQuery.of(context).size.width - 30,
                        color: Colors.white,
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text("Species ID:",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16)),
                                Spacer(),
                                Text(pokemon.id.toString(),
                                    style: TextStyle(fontSize: 16))
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Text("Height:",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16)),
                                Spacer(),
                                Text(calcMetric(pokemon.height, false),
                                    style: TextStyle(fontSize: 16))
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Text("Weight:",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16)),
                                Spacer(),
                                Text(calcMetric(pokemon.weight, true),
                                    style: TextStyle(fontSize: 16))
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Text("Type(s):",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16)),
                                Spacer(),
                                getTypes(pokemon.types)
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Text("Base Experience:",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16)),
                                Spacer(),
                                Text("${pokemon.baseExperience}",
                                    style: TextStyle(fontSize: 16))
                              ],
                            ),
                            Row(
                              children: <Widget>[Text("")],
                            ),
                            Row(
                              children: <Widget>[
                                Text("Description:",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold))
                              ],
                            ),
                            Flexible(
                              child: Text(
                                  removeLineBreaks(
                                      species.flavorTextEntries[1].flavorText),
                                  style: TextStyle(fontSize: 16)),
                            ),
                            // Row(
                            //   children: <Widget>[
                            //     Text("Evolution Chain:",
                            //         style: TextStyle(
                            //             fontSize: 16,
                            //             fontWeight: FontWeight.bold)),
                            //   ],
                            // ),
                            //Add evolution chain with images that nav to evoled pokemon details
                          ],
                        ),
                      ),
                    )
                  ]))));
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text("Loading"),
        ),
        body: Center(child: CircularProgressIndicator()),
      );
    }
  }
}
