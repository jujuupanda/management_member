import 'package:get_it/get_it.dart';

import 'features/attendance/data/data_sources/attendance_remote_data_source.dart';
import 'features/attendance/data/repositories/attendance_repository_impl.dart';
import 'features/attendance/domain/use_cases/attend_checker_use_case.dart';
import 'features/attendance/domain/use_cases/check_in_use_case.dart';
import 'features/attendance/domain/use_cases/check_out_use_case.dart';
import 'features/attendance/presentation/manager/attendance_bloc.dart';
import 'features/login/data/data_sources/auth_remote_data_source.dart';
import 'features/login/data/repositories/auth_repository_impl.dart';
import 'features/login/domain/use_cases/login_checker_use_case.dart';
import 'features/login/domain/use_cases/login_use_case.dart';
import 'features/login/domain/use_cases/logout_use_case.dart';
import 'features/login/presentation/manager/auth_bloc.dart';
import 'features/profile/data/data_sources/profile_remote_data_source.dart';
import 'features/profile/data/repositories/profile_repository_impl.dart';
import 'features/profile/domain/use_cases/get_profile_use_case.dart';
import 'features/profile/presentation/manager/profile_bloc.dart';

final getIt = GetIt.instance;

void serviceLocator() async {
  /// Data Sources
  // Auth
  getIt.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSource());
  //Profile
  getIt.registerLazySingleton<ProfileRemoteDataSource>(
      () => ProfileRemoteDataSource());
  //Attendance
  getIt.registerLazySingleton<AttendanceRemoteDataSource>(
      () => AttendanceRemoteDataSource());

  /// Repositories
  // Auth
  getIt.registerLazySingleton<AuthRepositoryImpl>(
    () => AuthRepositoryImpl(
      remoteDataSource: getIt<AuthRemoteDataSource>(),
    ),
  );
  //Profile
  getIt.registerLazySingleton<ProfileRepositoryImpl>(
    () => ProfileRepositoryImpl(
      remoteDataSource: getIt<ProfileRemoteDataSource>(),
    ),
  );
  //Attendance
  getIt.registerLazySingleton<AttendanceRepositoryImpl>(
    () => AttendanceRepositoryImpl(
      remoteDataSource: getIt<AttendanceRemoteDataSource>(),
    ),
  );

  /// Use Cases
  //Auth
  getIt.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(getIt<AuthRepositoryImpl>()),
  );
  getIt.registerLazySingleton<LogoutUseCase>(
    () => LogoutUseCase(getIt<AuthRepositoryImpl>()),
  );
  getIt.registerLazySingleton<LoginCheckerUseCase>(
    () => LoginCheckerUseCase(getIt<AuthRepositoryImpl>()),
  );
  //Profile
  getIt.registerLazySingleton<GetProfileUseCase>(
    () => GetProfileUseCase(getIt<ProfileRepositoryImpl>()),
  );
  //Attendance
  getIt.registerLazySingleton<CheckInUseCase>(
    () => CheckInUseCase(
      getIt<AttendanceRepositoryImpl>(),
    ),
  );
  getIt.registerLazySingleton<CheckOutUseCase>(
        () => CheckOutUseCase(
      getIt<AttendanceRepositoryImpl>(),
    ),
  );
  getIt.registerLazySingleton<AttendCheckerUseCase>(
        () => AttendCheckerUseCase(
      getIt<AttendanceRepositoryImpl>(),
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
  //Profile
  getIt.registerFactory<ProfileBloc>(
    () => ProfileBloc(
      getProfileUseCase: getIt<GetProfileUseCase>(),
    ),
  );
  //Attendance
  getIt.registerFactory<AttendanceBloc>(
    () => AttendanceBloc(
      checkInUseCase: getIt<CheckInUseCase>(),
      checkOutUseCase: getIt<CheckOutUseCase>(),
      attendCheckerUseCase: getIt<AttendCheckerUseCase>(),
    ),
  );

  /// Outside
}
