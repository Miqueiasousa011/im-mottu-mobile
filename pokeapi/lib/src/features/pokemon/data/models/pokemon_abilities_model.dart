import '../../domain/entities/pokemon_abilities.dart';

class PokemonAbilitiesModel {
  final String name;
  final String url;

  const PokemonAbilitiesModel({required this.name, required this.url});

  factory PokemonAbilitiesModel.fromJson(Map<String, dynamic> json) {
    return PokemonAbilitiesModel(name: json['name'], url: json['url']);
  }

  PokemonAbilities toPokemonAbilities() {
    return PokemonAbilities(name: name, url: url);
  }
}
