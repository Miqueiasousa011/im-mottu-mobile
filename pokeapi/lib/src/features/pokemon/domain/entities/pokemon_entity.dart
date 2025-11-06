import 'package:equatable/equatable.dart';

import 'pokemon_abilities.dart';

class PokemonEntity extends Equatable {
  final int id;
  final String name;
  final String imageUrl;
  final double weight;
  final double height;
  final List<PokemonAbilities> abilities;

  const PokemonEntity({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.weight,
    required this.height,
    required this.abilities,
  });

  @override
  List<Object?> get props => [id, name, imageUrl, weight, height, abilities];
}
