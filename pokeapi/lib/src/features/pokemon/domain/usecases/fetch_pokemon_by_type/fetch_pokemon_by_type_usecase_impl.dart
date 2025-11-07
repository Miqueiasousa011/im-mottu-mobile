import '../../entities/pokemon_entity.dart';
import '../../repositories/pokemon_repository.dart';
import 'fetch_pokemon_by_type_usecase.dart';

class FetchPokemonByTypeUsecaseImpl implements FetchPokemonByTypeUsecase {
  final PokemonRepository _repository;

  FetchPokemonByTypeUsecaseImpl({required PokemonRepository repository})
    : _repository = repository;

  @override
  Future<List<PokemonEntity>> call({required String type}) async {
    return _repository.fetchPokemonsByType(type: type);
  }
}
