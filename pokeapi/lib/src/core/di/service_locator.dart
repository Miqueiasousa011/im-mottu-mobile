import 'package:get_it/get_it.dart';
import 'package:pokeapi/src/features/pokemon/domain/repositories/pokemon_repository.dart';

import '../../features/pokemon/data/datasources/local/pokemon_loca_datasource_impl.dart';
import '../../features/pokemon/data/datasources/pokemon_datasource.dart';
import '../../features/pokemon/data/datasources/pokemon_local_datasource.dart';
import '../../features/pokemon/data/datasources/remote/pokemon_remote_datasource.dart';
import '../../features/pokemon/data/repositories/pokemon_repository_impl.dart';
import '../../features/pokemon/domain/usecases/clear_cache/clear_cache_usecase.dart';
import '../../features/pokemon/domain/usecases/clear_cache/clear_cache_usecase_impl.dart';
import '../../features/pokemon/domain/usecases/fetch_pokemon_by_type/fetch_pokemon_by_type_usecase.dart';
import '../../features/pokemon/domain/usecases/fetch_pokemon_by_type/fetch_pokemon_by_type_usecase_impl.dart';
import '../../features/pokemon/domain/usecases/fetch_pokemons/fetch_pokemons_usecase.dart';
import '../../features/pokemon/domain/usecases/fetch_pokemons/fetch_pokemons_usecase_impl.dart';
import '../../features/pokemon/presentation/notifiers/pokemon_details_notifier.dart';
import '../../features/pokemon/presentation/notifiers/pokemon_notifier.dart';
import '../database/app_database.dart';
import '../services/http_client/dio_http_client_service.dart';
import '../services/http_client/http_client_service.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  /// SQFlite Database
  getIt.registerLazySingleton<AppDatabase>(() => AppDatabase());

  /// Services
  getIt.registerLazySingleton<HttpClientService>(
    () => DioHttpClientService(baseUrl: 'https://pokeapi.co/api/v2'),
  );

  /// Datasources
  getIt.registerLazySingleton<PokemonDatasource>(
    () =>
        PokemonRemoteDatasource(httpClientService: getIt<HttpClientService>()),
  );

  getIt.registerLazySingleton<PokemonLocalDatasource>(
    () => PokemonLocalDatasourceImpl(getIt<AppDatabase>()),
  );

  /// Repositories
  getIt.registerLazySingleton<PokemonRepository>(
    () => PokemonRepositoryImpl(
      remoteDatasource: getIt<PokemonDatasource>(),
      localDatasource: getIt<PokemonLocalDatasource>(),
    ),
  );

  /// UseCases
  getIt.registerLazySingleton<FetchPokemonsUseCase>(
    () => FetchPokemonsUsecaseImpl(repository: getIt<PokemonRepository>()),
  );

  getIt.registerLazySingleton<ClearCacheUsecase>(
    () => ClearCacheUsecaseImpl(pokemonRepository: getIt<PokemonRepository>()),
  );

  getIt.registerLazySingleton<FetchPokemonByTypeUsecase>(
    () => FetchPokemonByTypeUsecaseImpl(repository: getIt<PokemonRepository>()),
  );

  /// Notifiers
  getIt.registerFactory(
    () => PokemonNotifier(
      fetchPokemonsUseCase: getIt<FetchPokemonsUseCase>(),
      clearCacheUseCase: getIt<ClearCacheUsecase>(),
    ),
  );

  getIt.registerFactory(
    () => PokemonDetailsNotifier(
      fetchPokemonByTypeUsecase: getIt<FetchPokemonByTypeUsecase>(),
    ),
  );
}
