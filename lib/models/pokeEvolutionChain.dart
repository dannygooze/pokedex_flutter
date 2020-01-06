import 'package:http/http.dart' as http;
import 'dart:convert';

Future<PokeEvolutionChain> fetchPokeEvoChain(String url) async {
  final response = await http.get("$url");

  if (response.statusCode == 200) {
    return PokeEvolutionChain.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load pokemon');
  }
}

class PokeEvolutionChain {
  Chain chain;
  int id;

  PokeEvolutionChain({this.chain, this.id});

  PokeEvolutionChain.fromJson(Map<String, dynamic> json) {
    chain = json['chain'] != null ? new Chain.fromJson(json['chain']) : null;
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.chain != null) {
      data['chain'] = this.chain.toJson();
    }
    data['id'] = this.id;
    return data;
  }
}

class Chain {
  List<EvolvesTo> evolvesTo;
  bool isBaby;
  Trigger species;

  Chain({this.evolvesTo, this.isBaby, this.species});

  Chain.fromJson(Map<String, dynamic> json) {
    if (json['evolves_to'] != null) {
      evolvesTo = new List<EvolvesTo>();
      json['evolves_to'].forEach((v) {
        evolvesTo.add(new EvolvesTo.fromJson(v));
      });
    }
    isBaby = json['is_baby'];
    species =
        json['species'] != null ? new Trigger.fromJson(json['species']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.evolvesTo != null) {
      data['evolves_to'] = this.evolvesTo.map((v) => v.toJson()).toList();
    }
    data['is_baby'] = this.isBaby;
    if (this.species != null) {
      data['species'] = this.species.toJson();
    }
    return data;
  }
}

class EvolvesTo {
  List<EvolutionDetails> evolutionDetails;
  List<EvolvesTo> evolvesTo;
  bool isBaby;
  Trigger species;

  EvolvesTo({this.evolutionDetails, this.evolvesTo, this.isBaby, this.species});

  EvolvesTo.fromJson(Map<String, dynamic> json) {
    if (json['evolution_details'] != null) {
      evolutionDetails = new List<EvolutionDetails>();
      json['evolution_details'].forEach((v) {
        evolutionDetails.add(new EvolutionDetails.fromJson(v));
      });
    }
    if (json['evolves_to'] != null) {
      evolvesTo = new List<EvolvesTo>();
      json['evolves_to'].forEach((v) {
        evolvesTo.add(new EvolvesTo.fromJson(v));
      });
    }
    isBaby = json['is_baby'];
    species =
        json['species'] != null ? new Trigger.fromJson(json['species']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.evolutionDetails != null) {
      data['evolution_details'] =
          this.evolutionDetails.map((v) => v.toJson()).toList();
    }
    if (this.evolvesTo != null) {
      data['evolves_to'] = this.evolvesTo.map((v) => v.toJson()).toList();
    }
    data['is_baby'] = this.isBaby;
    if (this.species != null) {
      data['species'] = this.species.toJson();
    }
    return data;
  }
}

class EvolutionDetails {
  Null gender;
  Null heldItem;
  Null item;
  Null knownMove;
  Null knownMoveType;
  Null location;
  Null minAffection;
  Null minBeauty;
  Null minHappiness;
  int minLevel;
  bool needsOverworldRain;
  Null partySpecies;
  Null partyType;
  Null relativePhysicalStats;
  String timeOfDay;
  Null tradeSpecies;
  Trigger trigger;
  bool turnUpsideDown;

  EvolutionDetails(
      {this.gender,
      this.heldItem,
      this.item,
      this.knownMove,
      this.knownMoveType,
      this.location,
      this.minAffection,
      this.minBeauty,
      this.minHappiness,
      this.minLevel,
      this.needsOverworldRain,
      this.partySpecies,
      this.partyType,
      this.relativePhysicalStats,
      this.timeOfDay,
      this.tradeSpecies,
      this.trigger,
      this.turnUpsideDown});

  EvolutionDetails.fromJson(Map<String, dynamic> json) {
    gender = json['gender'];
    heldItem = json['held_item'];
    item = json['item'];
    knownMove = json['known_move'];
    knownMoveType = json['known_move_type'];
    location = json['location'];
    minAffection = json['min_affection'];
    minBeauty = json['min_beauty'];
    minHappiness = json['min_happiness'];
    minLevel = json['min_level'];
    needsOverworldRain = json['needs_overworld_rain'];
    partySpecies = json['party_species'];
    partyType = json['party_type'];
    relativePhysicalStats = json['relative_physical_stats'];
    timeOfDay = json['time_of_day'];
    tradeSpecies = json['trade_species'];
    trigger =
        json['trigger'] != null ? new Trigger.fromJson(json['trigger']) : null;
    turnUpsideDown = json['turn_upside_down'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['gender'] = this.gender;
    data['held_item'] = this.heldItem;
    data['item'] = this.item;
    data['known_move'] = this.knownMove;
    data['known_move_type'] = this.knownMoveType;
    data['location'] = this.location;
    data['min_affection'] = this.minAffection;
    data['min_beauty'] = this.minBeauty;
    data['min_happiness'] = this.minHappiness;
    data['min_level'] = this.minLevel;
    data['needs_overworld_rain'] = this.needsOverworldRain;
    data['party_species'] = this.partySpecies;
    data['party_type'] = this.partyType;
    data['relative_physical_stats'] = this.relativePhysicalStats;
    data['time_of_day'] = this.timeOfDay;
    data['trade_species'] = this.tradeSpecies;
    if (this.trigger != null) {
      data['trigger'] = this.trigger.toJson();
    }
    data['turn_upside_down'] = this.turnUpsideDown;
    return data;
  }
}

class Trigger {
  String name;
  String url;

  Trigger({this.name, this.url});

  Trigger.fromJson(Map<String, dynamic> json) {
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
