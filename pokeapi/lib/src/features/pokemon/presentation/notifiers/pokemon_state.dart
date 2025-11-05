part of 'pokemon_notifier.dart';

abstract class PokemonState extends Equatable {
  const PokemonState();
  @override
  List<Object?> get props => [];
}

class PokemonInitialState extends PokemonState {}

class PokemonLoadingState extends PokemonState {}

class PokemonLoadedState extends PokemonState {
  final List<PokemonEntity> pokemons;

  const PokemonLoadedState({required this.pokemons});

  @override
  List<Object?> get props => [pokemons];
}

class PokemonErrorState extends PokemonState {
  final String message;

  const PokemonErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}
