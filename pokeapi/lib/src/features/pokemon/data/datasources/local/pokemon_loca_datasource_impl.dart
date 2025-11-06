import 'package:pokeapi/src/core/database/db_tables.dart';
import 'package:pokeapi/src/features/pokemon/data/models/pokemon_details_model.dart';
import 'package:sqflite/sqlite_api.dart';

import '../../../../../core/database/app_database.dart';
import '../pokemon_local_datasource.dart';

class PokemonLocalDatasourceImpl implements PokemonLocalDatasource {
  final AppDatabase database;

  const PokemonLocalDatasourceImpl(this.database);

  @override
  Future<List<PokemonDetailsModel>?> fetchPokemons() {
    throw UnimplementedError();
  }

  @override
  Future<void> savePokemons({
    required List<PokemonDetailsModel> pokemons,
  }) async {
    final db = await database.getDatabase();

    await db.transaction((t) async {
      final batch = t.batch();

      for (final pokemon in pokemons) {
        batch.insert(DbTables.pokemons, {
          'id': pokemon.id,
          'name': pokemon.name,
          'weight': pokemon.weight,
          'height': pokemon.height,
          'imageUrl': pokemon.imageUrl,
        }, conflictAlgorithm: ConflictAlgorithm.replace);

        for (final type in pokemon.types) {
          batch.insert(DbTables.pokemonTypes, {
            'pokemon_id': pokemon.id,
            'name': type.name,
            'url': type.url,
          }, conflictAlgorithm: ConflictAlgorithm.replace);
        }

        for (final ability in pokemon.abilities) {
          batch.insert(
            DbTables.pokemonAbilities,
            {
              'pokemon_id': pokemon.id,
              'name': ability.name,
              'url': ability.url,
            },
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
        }
      }

      await batch.commit(noResult: true);
    });
  }
}
