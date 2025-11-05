import '../../entities/pokemon_entity.dart';
import '../../repositories/pokemon_repository.dart';
import 'fetch_pokemons_usecase.dart';

class FetchPokemonsUsecaseImpl implements FetchPokemonsUseCase {
  final PokemonRepository repository;

  const FetchPokemonsUsecaseImpl(this.repository);

  @override
  Future<List<PokemonEntity>> call({required int pageLimit, required int pageOffset}) {
    return repository.fetchPokemons(pageLimit: pageLimit, pageOffset: pageOffset);
  }
}
