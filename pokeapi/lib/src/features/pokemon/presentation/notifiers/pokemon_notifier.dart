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

  int _pageOffset = 0;
  static const _pageLimit = 10;

  List<PokemonEntity> _pokemonsList = [];

  Future<void> fetchPokemons() async {
    value = value.copyWith(status: PokemonStatus.loading);
    try {
      final pokemons = await _fetchPokemonsUseCase(
        pageLimit: _pageLimit,
        pageOffset: _pageOffset,
      );

      _pageOffset += _pageLimit;

      _pokemonsList = [..._pokemonsList, ...pokemons];

      value = value.copyWith(
        pokemons: _pokemonsList,
        status: PokemonStatus.loaded,
      );
    } catch (e) {
      value = value.copyWith(status: PokemonStatus.error);
    }
  }

  void filterPokemons(String filter) {
    if (filter.isEmpty) {
      value = value.copyWith(
        pokemons: _pokemonsList,
        status: PokemonStatus.loaded,
      );
      return;
    }

    final filteredPokemons = _pokemonsList
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
