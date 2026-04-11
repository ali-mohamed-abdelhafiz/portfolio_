import 'package:get_it/get_it.dart';
import '../api/dio_client.dart';
import '../../features/portfolio/data/repositories/projects_repository.dart';
import '../../features/portfolio/presentation/cubit/projects_cubit.dart';
import '../theme/theme_cubit.dart';

final sl = GetIt.instance;

void init() {
  // Core
  sl.registerLazySingleton<DioClient>(() => DioClient());
  sl.registerLazySingleton<ThemeCubit>(() => ThemeCubit());

  // Repositories
  sl.registerLazySingleton<ProjectsRepository>(
    () => ProjectsRepository(dioClient: sl()),
  );

  // Cubits
  sl.registerFactory<ProjectsCubit>(
    () => ProjectsCubit(repository: sl()),
  );
}
