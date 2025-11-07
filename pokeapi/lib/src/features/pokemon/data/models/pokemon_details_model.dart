import 'package:pokeapi/src/features/pokemon/domain/entities/pokemon_entity.dart';

import 'pokemon_abilities_model.dart';
import 'pokemon_type_model.dart';

class PokemonDetailsModel {
  final int id;
  final String name;
  final double weight;
  final double height;
  final String imageUrl;
  final List<PokemonTypeModel> types;
  final List<PokemonAbilitiesModel> abilities;

  const PokemonDetailsModel({
    required this.id,
    required this.name,
    required this.weight,
    required this.height,
    required this.imageUrl,
    required this.types,
    required this.abilities,
  });

  factory PokemonDetailsModel.fromMap(Map<String, dynamic> map) {
    return PokemonDetailsModel(
      id: map['id'],
      name: map['name'],
      weight: double.parse(map['weight'].toString()),
      height: double.parse(map['height'].toString()),
      imageUrl: map['sprites']?['front_default'] ?? '',
      abilities: List<PokemonAbilitiesModel>.from(
        map['abilities'].map(
          (ability) => PokemonAbilitiesModel.fromJson(ability['ability']),
        ),
      ),
      types: List<PokemonTypeModel>.from(
        map['types'].map((type) => PokemonTypeModel.fromJson(type['type'])),
      ),
    );
  }

  PokemonEntity toPokemonEntity() {
    return PokemonEntity(
      id: id,
      name: name,
      weight: weight,
      height: height,
      imageUrl: imageUrl,
      types: types.map((type) => type.toPokemonType()).toList(),
      abilities: abilities
          .map((ability) => ability.toPokemonAbilities())
          .toList(),
    );
  }
}
