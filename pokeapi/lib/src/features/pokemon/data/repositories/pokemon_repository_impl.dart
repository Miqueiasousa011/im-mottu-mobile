import 'package:pokeapi/src/features/pokemon/domain/entities/pokemon_entity.dart';

import '../../domain/repositories/pokemon_repository.dart';
import '../datasources/pokemon_datasource.dart';
import '../datasources/pokemon_local_datasource.dart';

class PokemonRepositoryImpl implements PokemonRepository {
  final PokemonDatasource _remoteDatasource;
  final PokemonLocalDatasource _localDatasource;

  const PokemonRepositoryImpl({
    required PokemonDatasource remoteDatasource,
    required PokemonLocalDatasource localDatasource,
  }) : _remoteDatasource = remoteDatasource,
       _localDatasource = localDatasource;

  @override
  Future<List<PokemonEntity>> fetchPokemons({
    required int pageLimit,
    required int pageOffset,
  }) async {
    try {
      final pokemonList = await _remoteDatasource.fetchPokemonList(
        pageLimit: pageLimit,
        pageOffset: pageOffset,
      );

      final pokemonDetails = await Future.wait(
        pokemonList.map(
          (pokemon) =>
              _remoteDatasource.fetchPokemonDetails(pokemonId: pokemon.id),
        ),
      );

      await _localDatasource.savePokemons(pokemons: pokemonDetails);

      return pokemonDetails
          .map((details) => details.toPokemonEntity())
          .toList();
    } catch (_) {
      final localPokemons = await _localDatasource.fetchPokemons(
        pageLimit: pageLimit,
        pageOffset: pageOffset,
      );

      return localPokemons.map((details) => details.toPokemonEntity()).toList();
    }
  }

  @override
  Future<void> clearCache() async {
    await _localDatasource.clearCache();
  }

  @override
  Future<List<PokemonEntity>> fetchPokemonsByType({
    required String type,
  }) async {
    final pokemonList = await _remoteDatasource.fetchPokemonsByType(type: type);

    final pokemonDetails = await Future.wait(
      pokemonList.map((pokemon) {
        return _remoteDatasource.fetchPokemonDetails(pokemonId: pokemon.id);
      }),
    );

    return pokemonDetails.map((details) => details.toPokemonEntity()).toList();
  }

  @override
  Future<List<PokemonEntity>> fetchPokemonsByAbility({
    required String ability,
  }) async {
    final pokemonList = await _remoteDatasource.fetchPokemonsByAbility(
      ability: ability,
    );

    final pokemonDetails = await Future.wait(
      pokemonList.map((pokemon) {
        return _remoteDatasource.fetchPokemonDetails(pokemonId: pokemon.id);
      }),
    );

    return pokemonDetails.map((details) => details.toPokemonEntity()).toList();
  }
}
