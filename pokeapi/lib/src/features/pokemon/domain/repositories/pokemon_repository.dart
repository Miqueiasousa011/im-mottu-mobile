import '../entities/pokemon_entity.dart';

abstract interface class PokemonRepository {
  Future<List<PokemonEntity>> fetchPokemons({
    required int pageLimit,
    required int pageOffset,
  });

  Future<List<PokemonEntity>> fetchPokemonsByType({required String type});

  Future<void> clearCache();
}
