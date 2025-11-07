import '../../entities/pokemon_entity.dart';

abstract interface class FetchPokemonByTypeUsecase {
  Future<List<PokemonEntity>> call({required String type});
}
