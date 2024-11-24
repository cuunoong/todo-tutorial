part of 'dependencies.dart';

final sl = GetIt.instance;

initializeDependencies() async {
  await Supabase.initialize(
    url: "YOUR_SUPABASE_URL",
    anonKey: "YOUR_SUPABAES_ANON_KEY",
  );

  sl.registerLazySingleton(() => Supabase.instance.client);

  _todo();
}

_todo() {
  sl
    // Data sources
    ..registerLazySingleton<TodoRemoteDataSource>(
        () => TodoRemoteDataSourceImpl(supabaseClient: sl()))
    // Repositories
    ..registerLazySingleton<TodoRepository>(
        () => TodoRepositoryImpl(remoteDataSource: sl()))
    // Use cases
    ..registerLazySingleton(() => AddTodoUseCase(repository: sl()))
    ..registerLazySingleton(() => DeleteTodoUseCase(repository: sl()))
    ..registerLazySingleton(() => GetTodosUseCase(repository: sl()))
    ..registerLazySingleton(() => UpdateTodoUseCase(repository: sl()))
    // Blocs
    ..registerFactory(
      () => TodoBloc(
        addTodoUseCase: sl(),
        getTodosUseCase: sl(),
        updateTodoUseCase: sl(),
        deleteTodoUseCase: sl(),
      ),
    );
}
