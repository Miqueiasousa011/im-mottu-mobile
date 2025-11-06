import '../../domain/entities/pokemon_type.dart';

class PokemonTypeModel {
  final String name;
  final String url;

  PokemonTypeModel({required this.name, required this.url});

  factory PokemonTypeModel.fromJson(Map<String, dynamic> json) {
    return PokemonTypeModel(name: json['name'], url: json['url']);
  }

  PokemonType toPokemonType() {
    return PokemonType(name: name, url: url);
  }
}
