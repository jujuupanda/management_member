import 'package:get_it/get_it.dart';

import 'features/login/data/data_sources/auth_remote_data_source.dart';
import 'features/login/data/repositories/auth_repository_impl.dart';
import 'features/login/domain/repositories/auth_repository.dart';
import 'features/login/domain/use_cases/login_checker_use_case.dart';
import 'features/login/domain/use_cases/login_use_case.dart';
import 'features/login/domain/use_cases/logout_use_case.dart';
import 'features/login/presentation/manager/auth_bloc.dart';

final getIt = GetIt.instance;

void serviceLocator() async {
  /// Data Sources
  // Auth
  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSource(),
  );

  /// Repositories
  // Auth
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      getIt<AuthRemoteDataSource>(),
    ),
  );

  /// Use Cases
  //Auth
  getIt.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(
      getIt<AuthRepository>(),
    ),
  );
  getIt.registerLazySingleton<LogoutUseCase>(
    () => LogoutUseCase(
      getIt<AuthRepository>(),
    ),
  );
  getIt.registerLazySingleton<LoginCheckerUseCase>(
    () => LoginCheckerUseCase(
      getIt<AuthRepository>(),
    ),
  );

  /// Bloc
  // Auth
  getIt.registerFactory<AuthBloc>(
    () => AuthBloc(
      loginUseCase: getIt<LoginUseCase>(),
      logoutUseCase: getIt<LogoutUseCase>(),
      loginCheckerUseCase: getIt<LoginCheckerUseCase>(),
    ),
  );

  /// Outside
}
