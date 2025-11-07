import 'package:flutter/material.dart';
import 'package:pokeapi/src/features/pokemon/domain/entities/pokemon_entity.dart';
import 'package:pokeapi/src/features/pokemon/presentation/ui/widgets/pokemon_trait_widget.dart';

import '../../../../../core/widgets/network_image_widget.dart';
import 'trait_item_widget.dart';

class PokemonExpansionTileWidget extends StatelessWidget {
  final PokemonEntity pokemon;
  const PokemonExpansionTileWidget({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(pokemon.name),
      leading: ImageNetworkWidget(
        pokemon.imageUrl,
        height: 50,
        width: 50,
        fit: BoxFit.contain,
      ),
      children: [
        Row(
          spacing: 16,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PokemonTraitWidget(
              traitName: 'Altura',
              traitDescription: '${pokemon.height.toInt()}',
            ),
            PokemonTraitWidget(
              traitName: 'Peso',
              traitDescription: '${pokemon.weight.toInt()}',
            ),
          ],
        ),

        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: const Text(
            'Habilidades',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),

        FittedBox(
          fit: BoxFit.scaleDown,
          child: Row(
            spacing: 16,
            mainAxisAlignment: MainAxisAlignment.center,
            children: pokemon.abilities
                .map((ability) => TraitItemWidget(description: ability.name))
                .toList(),
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: const Text(
            'Tipos',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),

        Row(
          spacing: 16,
          mainAxisAlignment: MainAxisAlignment.center,
          children: pokemon.types
              .map((type) => TraitItemWidget(description: type.name))
              .toList(),
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}
