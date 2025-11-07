import '../entities/pokemon_entity.dart';

abstract interface class PokemonRepository {
  Future<List<PokemonEntity>> fetchPokemons({
    required int pageLimit,
    required int pageOffset,
  });

  Future<List<PokemonEntity>> fetchPokemonsByType({required String type});

  Future<List<PokemonEntity>> fetchPokemonsByAbility({required String ability});

  Future<void> clearCache();
}
