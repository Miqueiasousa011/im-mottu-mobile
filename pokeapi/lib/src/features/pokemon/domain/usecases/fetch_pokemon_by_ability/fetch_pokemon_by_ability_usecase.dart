import '../../entities/pokemon_entity.dart';

abstract interface class FetchPokemonByAbilityUsecase {
  Future<List<PokemonEntity>> call({required String ability});
}
