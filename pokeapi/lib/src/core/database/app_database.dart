import 'package:pokeapi/src/core/database/db_tables.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class AppDatabase {
  final _databaseName = 'mottu_pokeapi.db';
  final _databaseVersion = 1;

  Database? _database;

  Future<Database> getDatabase() async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, _databaseName);

    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute(DbTables.createPokemonTable);
    await db.execute(DbTables.createPokemonTypeTable);
    await db.execute(DbTables.createPokemonAbilityTable);
  }

  Future<void> closeDatabase() async {
    if (_database != null) {
      await _database!.close();
      _database = null;
    }
  }

  Future<void> clearCache() async {
    final db = await getDatabase();
    final batch = db.batch();

    batch.delete(DbTables.pokemons);
    batch.delete(DbTables.pokemonTypes);
    batch.delete(DbTables.pokemonAbilities);

    await batch.commit(noResult: true);
  }
}
