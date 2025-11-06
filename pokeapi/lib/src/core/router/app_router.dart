import 'package:go_router/go_router.dart';

import '../../features/pokemon/presentation/ui/pages/pokemon_list_page.dart';

class AppRouter {
  static const paths = (
    initial: (path: '/', name: 'initial'),
    pokemonDetails: (path: '/pokemon-details', name: 'pokemon-details'),
  );

  static final router = GoRouter(
    initialLocation: paths.initial.path,
    routes: [
      GoRoute(
        path: paths.initial.path,
        name: paths.initial.name,
        builder: (context, state) => const PokemonListPage(),
      ),
    ],
  );
}
