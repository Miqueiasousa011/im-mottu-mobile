class DbTables {
  static const String pokemons = 'pokemon';
  static const String pokemonTypes = 'pokemon_type';
  static const String pokemonAbilities = 'pokemon_ability';

  static const String createPokemonTable =
      '''
      CREATE TABLE $pokemons (
            id INTEGER PRIMARY KEY,
            name TEXT,
            weight REAL,
            height REAL,
            image_url TEXT
      );
''';

  static const String createPokemonTypeTable =
      '''
      CREATE TABLE $pokemonTypes (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            pokemon_id INTEGER,
            name TEXT,
            url TEXT,
            UNIQUE(pokemon_id, url),
            FOREIGN KEY (pokemon_id) REFERENCES $pokemons(id)
      );
''';

  static const String createPokemonAbilityTable =
      '''
      CREATE TABLE $pokemonAbilities (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            pokemon_id INTEGER,
            name TEXT,
            url TEXT,
            UNIQUE(pokemon_id, url),
            FOREIGN KEY (pokemon_id) REFERENCES $pokemons(id)
      );
''';
}
