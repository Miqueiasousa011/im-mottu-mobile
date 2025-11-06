import 'package:pokeapi/src/core/database/db_tables.dart';
import 'package:pokeapi/src/features/pokemon/data/models/pokemon_details_model.dart';
import 'package:sqflite/sqlite_api.dart';

import '../../../../../core/database/app_database.dart';
import '../../models/pokemon_abilities_model.dart';
import '../../models/pokemon_type_model.dart';
import '../pokemon_local_datasource.dart';

class PokemonLocalDatasourceImpl implements PokemonLocalDatasource {
  final AppDatabase database;

  const PokemonLocalDatasourceImpl(this.database);

  @override
  Future<List<PokemonDetailsModel>> fetchPokemons() async {
    final db = await database.getDatabase();

    final pokemonsMap = await db.query(DbTables.pokemons);

    if (pokemonsMap.isEmpty) {
      return [];
    }

    final List<PokemonDetailsModel> pokemons = [];

    for (final pokemonMap in pokemonsMap) {
      final pokemonId = pokemonMap['id'];

      final typesMap = await db.query(
        DbTables.pokemonTypes,
        where: 'pokemon_id = ?',
        whereArgs: [pokemonId],
      );

      final abilitiesMap = await db.query(
        DbTables.pokemonAbilities,
        where: 'pokemon_id = ?',
        whereArgs: [pokemonId],
      );

      final types = typesMap
          .map(
            (typeMap) => PokemonTypeModel(
              name: typeMap['name'] as String,
              url: typeMap['url'] as String,
            ),
          )
          .toList();

      final abilities = abilitiesMap
          .map(
            (abilityMap) => PokemonAbilitiesModel(
              name: abilityMap['name'] as String,
              url: abilityMap['url'] as String,
            ),
          )
          .toList();

      final pokemon = PokemonDetailsModel(
        id: pokemonMap['id'] as int,
        name: pokemonMap['name'] as String,
        weight: pokemonMap['weight'] as double,
        height: pokemonMap['height'] as double,
        imageUrl: pokemonMap['image_url'] as String,
        types: types,
        abilities: abilities,
      );

      pokemons.add(pokemon);
    }

    return pokemons;
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
          'image_url': pokemon.imageUrl,
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
