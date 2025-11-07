import '../../entities/pokemon_entity.dart';
import '../../repositories/pokemon_repository.dart';
import 'fetch_pokemon_by_ability_usecase.dart';

class FetchPokemonByAbilityUsecaseImpl implements FetchPokemonByAbilityUsecase {
  final PokemonRepository _repository;

  FetchPokemonByAbilityUsecaseImpl({required PokemonRepository repository})
    : _repository = repository;

  @override
  Future<List<PokemonEntity>> call({required String ability}) async {
    return _repository.fetchPokemonsByAbility(ability: ability);
  }
}
