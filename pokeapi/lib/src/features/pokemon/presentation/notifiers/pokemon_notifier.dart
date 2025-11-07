import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:pokeapi/src/features/pokemon/domain/usecases/clear_cache/clear_cache_usecase.dart';
import 'package:pokeapi/src/features/pokemon/domain/usecases/fetch_pokemons/fetch_pokemons_usecase.dart';

import '../../domain/entities/pokemon_entity.dart';

part 'pokemon_state.dart';

class PokemonNotifier extends ValueNotifier<PokemonState> {
  final FetchPokemonsUseCase _fetchPokemonsUseCase;
  final ClearCacheUsecase _clearCacheUseCase;

  PokemonNotifier({
    required FetchPokemonsUseCase fetchPokemonsUseCase,
    required ClearCacheUsecase clearCacheUseCase,
  }) : _fetchPokemonsUseCase = fetchPokemonsUseCase,
       _clearCacheUseCase = clearCacheUseCase,
       super(PokemonState());

  final _pageOffset = 0;
  static const _pageLimit = 100;

  List<PokemonEntity> pokemons = [];

  Future<void> fetchPokemons() async {
    value = value.copyWith(status: PokemonStatus.loading);
    try {
      final pokemons = await _fetchPokemonsUseCase(
        pageLimit: _pageLimit,
        pageOffset: _pageOffset,
      );
      this.pokemons = pokemons;
      value = value.copyWith(pokemons: pokemons, status: PokemonStatus.loaded);
    } catch (e) {
      value = value.copyWith(status: PokemonStatus.error);
    }
  }

  void filterPokemons(String filter) {
    if (filter.isEmpty) {
      value = value.copyWith(pokemons: pokemons, status: PokemonStatus.loaded);
      return;
    }

    final filteredPokemons = pokemons
        .where(
          (pokemon) =>
              pokemon.name.toLowerCase().contains(filter.toLowerCase()),
        )
        .toList();

    value = value.copyWith(
      pokemons: filteredPokemons,
      status: PokemonStatus.loaded,
    );
  }

  Future<void> clearCache() async {
    await _clearCacheUseCase();
  }
}
