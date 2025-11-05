import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:pokeapi/src/features/pokemon/domain/usecases/fetch_pokemons/fetch_pokemons_usecase.dart';

import '../../domain/entities/pokemon_entity.dart';

part 'pokemon_state.dart';

class PokemonNotifier extends ValueNotifier<PokemonState> {
  final FetchPokemonsUseCase _fetchPokemonsUseCase;

  PokemonNotifier({required FetchPokemonsUseCase fetchPokemonsUseCase})
    : _fetchPokemonsUseCase = fetchPokemonsUseCase,
      super(PokemonInitialState());

  final _pageOffset = 0;
  static const _pageLimit = 100;

  Future<void> fetchPokemons() async {
    value = PokemonLoadingState();
    try {
      final pokemons = await _fetchPokemonsUseCase(
        pageLimit: _pageLimit,
        pageOffset: _pageOffset,
      );
      value = PokemonLoadedState(pokemons: pokemons);
    } catch (e) {
      value = PokemonErrorState(message: 'Falha ao carregar Pokémons');
    }
  }
}
