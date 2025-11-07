part of './pokemon_details_notifier.dart';

abstract class PokemonDetailsState extends Equatable {
  const PokemonDetailsState();

  @override
  List<Object?> get props => [];
}

class PokemonDetailsInitial extends PokemonDetailsState {}

class PokemonDetailsLoading extends PokemonDetailsState {}

class PokemonDetailsLoaded extends PokemonDetailsState {
  final List<PokemonEntity> pokemon;

  const PokemonDetailsLoaded({required this.pokemon});

  @override
  List<Object?> get props => [pokemon];
}

class PokemonDetailsError extends PokemonDetailsState {
  final String message;

  const PokemonDetailsError({required this.message});
}
