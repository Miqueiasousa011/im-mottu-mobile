import '../models/pokemon_details_model.dart';

abstract interface class PokemonLocalDatasource {
  Future<void> savePokemons({required List<PokemonDetailsModel> pokemons});
  Future<List<PokemonDetailsModel>> fetchPokemons({
    required int pageLimit,
    required int pageOffset,
  });
  Future<void> clearCache();
}
