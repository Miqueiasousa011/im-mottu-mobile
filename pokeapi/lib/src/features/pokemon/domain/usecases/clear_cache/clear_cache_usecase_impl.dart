import '../../repositories/pokemon_repository.dart';
import 'clear_cache_usecase.dart';

class ClearCacheUsecaseImpl implements ClearCacheUsecase {
  final PokemonRepository _pokemonRepository;

  const ClearCacheUsecaseImpl({required PokemonRepository pokemonRepository})
    : _pokemonRepository = pokemonRepository;

  @override
  Future<void> call() async {
    await _pokemonRepository.clearCache();
  }
}
