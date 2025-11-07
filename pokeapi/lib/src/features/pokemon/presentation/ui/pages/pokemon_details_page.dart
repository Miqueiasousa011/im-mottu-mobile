import 'package:flutter/material.dart';
import 'package:pokeapi/src/core/mixins/loading_overlay_mixin.dart';

import '../../../../../core/di/service_locator.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/network_image_widget.dart';
import '../../../domain/entities/pokemon_entity.dart';
import '../../notifiers/pokemon_details_notifier.dart';
import '../widgets/pokemon_trait_widget.dart';
import '../widgets/trait_item_widget.dart';

class PokemonDetailsPage extends StatefulWidget {
  const PokemonDetailsPage({super.key, required this.pokemon});

  final PokemonEntity pokemon;

  @override
  State<PokemonDetailsPage> createState() => _PokemonDetailsPageState();
}

class _PokemonDetailsPageState extends State<PokemonDetailsPage>
    with LoadingOverlayMixin {
  late final PokemonDetailsNotifier pokemonDetailsNotifier;

  @override
  void initState() {
    pokemonDetailsNotifier = getIt<PokemonDetailsNotifier>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      pokemonDetailsNotifier.addListener(pokemonDetailsListener);
    });

    super.initState();
  }

  void pokemonDetailsListener() {
    final state = pokemonDetailsNotifier.value;

    if (state is PokemonDetailsLoading) {
      showLoading();
    } else {
      removeLoading();
    }

    if (state is PokemonDetailsError) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(state.message)));
    }
  }

  @override
  void dispose() {
    pokemonDetailsNotifier.removeListener(pokemonDetailsListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detalhes do Pokémon')),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Card(
          color: AppColors.white,
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Column(
              spacing: 16,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ImageNetworkWidget(
                  widget.pokemon.imageUrl,
                  height: 210,
                  width: 201,
                  fit: BoxFit.contain,
                ),
                Text(
                  widget.pokemon.name,
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center,
                ),

                Row(
                  spacing: 16,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    PokemonTraitWidget(
                      traitName: 'Altura',
                      traitDescription: '${widget.pokemon.height.toInt()}',
                    ),
                    PokemonTraitWidget(
                      traitName: 'Peso',
                      traitDescription: '${widget.pokemon.weight.toInt()}',
                    ),
                  ],
                ),

                const Text(
                  'Habilidades',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),

                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Row(
                    spacing: 16,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: widget.pokemon.abilities
                        .map(
                          (ability) =>
                              TraitItemWidget(description: ability.name),
                        )
                        .toList(),
                  ),
                ),

                const Text(
                  'Tipos',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),

                Row(
                  spacing: 16,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: widget.pokemon.types
                      .map(
                        (type) => InkWell(
                          onTap: () => pokemonDetailsNotifier
                              .fetchPokemonsByType(type.name),
                          child: TraitItemWidget(description: type.name),
                        ),
                      )
                      .toList(),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
