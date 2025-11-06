import 'package:flutter/material.dart';
import 'package:pokeapi/src/core/theme/app_colors.dart';

import '../../../../../core/widgets/network_image_widget.dart';
import '../../../domain/entities/pokemon_entity.dart';

class PokemonCardWidget extends StatelessWidget {
  final PokemonEntity pokemon;

  const PokemonCardWidget({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.white,
      child: Column(
        spacing: 16,
        children: [
          ImageNetworkWidget(
            pokemon.imageUrl,
            height: 150,
            width: 150,
            fit: BoxFit.cover,
          ),
          Text(pokemon.name, style: Theme.of(context).textTheme.titleMedium),
        ],
      ),
    );
  }
}
