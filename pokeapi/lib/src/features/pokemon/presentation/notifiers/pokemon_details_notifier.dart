import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

import '../../domain/entities/pokemon_entity.dart';
import '../../domain/usecases/fetch_pokemon_by_ability/fetch_pokemon_by_ability_usecase.dart';
import '../../domain/usecases/fetch_pokemon_by_type/fetch_pokemon_by_type_usecase.dart';

part 'pokemon_details_state.dart';

class PokemonDetailsNotifier extends ValueNotifier<PokemonDetailsState> {
  final FetchPokemonByTypeUsecase _fetchPokemonByTypeUsecase;
  final FetchPokemonByAbilityUsecase _fetchPokemonByAbilityUsecase;

  PokemonDetailsNotifier({
    required FetchPokemonByTypeUsecase fetchPokemonByTypeUsecase,
    required FetchPokemonByAbilityUsecase fetchPokemonByAbilityUsecase,
  }) : _fetchPokemonByTypeUsecase = fetchPokemonByTypeUsecase,
       _fetchPokemonByAbilityUsecase = fetchPokemonByAbilityUsecase,
       super(PokemonDetailsInitial());

  Future<void> fetchPokemonsByType(String type) async {
    try {
      value = PokemonDetailsLoading();
      final pokemons = await _fetchPokemonByTypeUsecase.call(type: type);
      value = PokemonDetailsLoaded(pokemons: pokemons);
    } catch (e) {
      value = PokemonDetailsError(
        message: 'Não foi possível carregar os Pokémons. Tente novamente.',
      );
    }
  }

  Future<void> fetchPokemonsByAbility(String ability) async {
    try {
      value = PokemonDetailsLoading();
      final pokemons = await _fetchPokemonByAbilityUsecase.call(
        ability: ability,
      );
      value = PokemonDetailsLoaded(pokemons: pokemons);
    } catch (e) {
      value = PokemonDetailsError(
        message: 'Não foi possível carregar os Pokémons. Tente novamente.',
      );
    }
  }
}
