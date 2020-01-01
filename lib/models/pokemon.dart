import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<Pokemon> fetchPokemon(int pokemonId) async {
  final response =
      await http.get('https://pokeapi.co/api/v2/pokemon/$pokemonId/');

  if (response.statusCode == 200) {
    return Pokemon.fromJson(json.decode(response.body));
  } else {
    print(response);
    throw Exception('Failed to load pokemon');
  }
}

Widget buildPokemonRow(Pokemon pokemon) {
  return ListTile(
    title: Text(
      '#$pokemon.id $pokemon.name',
      style: TextStyle(
        fontSize: 18.0, // insert your font size here
      ),
      textAlign: TextAlign.left,
    ),
    subtitle: Image.network(pokemon.sprites.frontDefault),
    onTap: () {
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //       builder: (context) => RegionList(region: regions[index])),
      // );
    },
  );
}

class Pokemon {
  int id;
  String name;
  int baseExperience;
  int height;
  bool isDefault;
  int order;
  int weight;
  Sprites sprites;
  List<Stats> stats;
  List<Types> types;

  Pokemon(
      {this.id,
      this.name,
      this.baseExperience,
      this.height,
      this.isDefault,
      this.order,
      this.weight,
      this.sprites,
      this.stats,
      this.types});

  Pokemon.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    baseExperience = json['base_experience'];
    height = json['height'];
    isDefault = json['is_default'];
    order = json['order'];
    weight = json['weight'];
    sprites =
        json['sprites'] != null ? new Sprites.fromJson(json['sprites']) : null;
    if (json['stats'] != null) {
      stats = new List<Stats>();
      json['stats'].forEach((v) {
        stats.add(new Stats.fromJson(v));
      });
    }
    if (json['types'] != null) {
      types = new List<Types>();
      json['types'].forEach((v) {
        types.add(new Types.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['base_experience'] = this.baseExperience;
    data['height'] = this.height;
    data['is_default'] = this.isDefault;
    data['order'] = this.order;
    data['weight'] = this.weight;
    if (this.sprites != null) {
      data['sprites'] = this.sprites.toJson();
    }
    if (this.stats != null) {
      data['stats'] = this.stats.map((v) => v.toJson()).toList();
    }
    if (this.types != null) {
      data['types'] = this.types.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Sprites {
  String backFemale;
  String backShinyFemale;
  String backDefault;
  String frontFemale;
  String frontShinyFemale;
  String backShiny;
  String frontDefault;
  String frontShiny;

  Sprites(
      {this.backFemale,
      this.backShinyFemale,
      this.backDefault,
      this.frontFemale,
      this.frontShinyFemale,
      this.backShiny,
      this.frontDefault,
      this.frontShiny});

  Sprites.fromJson(Map<String, dynamic> json) {
    backFemale = json['back_female'];
    backShinyFemale = json['back_shiny_female'];
    backDefault = json['back_default'];
    frontFemale = json['front_female'];
    frontShinyFemale = json['front_shiny_female'];
    backShiny = json['back_shiny'];
    frontDefault = json['front_default'];
    frontShiny = json['front_shiny'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['back_female'] = this.backFemale;
    data['back_shiny_female'] = this.backShinyFemale;
    data['back_default'] = this.backDefault;
    data['front_female'] = this.frontFemale;
    data['front_shiny_female'] = this.frontShinyFemale;
    data['back_shiny'] = this.backShiny;
    data['front_default'] = this.frontDefault;
    data['front_shiny'] = this.frontShiny;
    return data;
  }
}

class Stats {
  int baseStat;
  int effort;
  Stat stat;

  Stats({this.baseStat, this.effort, this.stat});

  Stats.fromJson(Map<String, dynamic> json) {
    baseStat = json['base_stat'];
    effort = json['effort'];
    stat = json['stat'] != null ? new Stat.fromJson(json['stat']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['base_stat'] = this.baseStat;
    data['effort'] = this.effort;
    if (this.stat != null) {
      data['stat'] = this.stat.toJson();
    }
    return data;
  }
}

class Stat {
  String name;
  String url;

  Stat({this.name, this.url});

  Stat.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['url'] = this.url;
    return data;
  }
}

class Types {
  int slot;
  Stat type;

  Types({this.slot, this.type});

  Types.fromJson(Map<String, dynamic> json) {
    slot = json['slot'];
    type = json['type'] != null ? new Stat.fromJson(json['type']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['slot'] = this.slot;
    if (this.type != null) {
      data['type'] = this.type.toJson();
    }
    return data;
  }
}
