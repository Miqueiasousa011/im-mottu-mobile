class PokemonAbilities {
  final String name;
  final String url;

  String get id {
    final uri = Uri.parse(url);
    return uri.pathSegments[uri.pathSegments.length - 2];
  }

  const PokemonAbilities({required this.name, required this.url});
}
