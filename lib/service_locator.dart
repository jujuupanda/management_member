import 'package:get_it/get_it.dart';

import 'features/attendance/data/data_sources/attendance_data_source.dart';
import 'features/attendance/data/repositories/attendance_repository_impl.dart';
import 'features/attendance/domain/use_cases/attend_checker_use_case.dart';
import 'features/attendance/domain/use_cases/check_in_use_case.dart';
import 'features/attendance/domain/use_cases/check_out_use_case.dart';
import 'features/attendance/domain/use_cases/get_attendance_use_case.dart';
import 'features/attendance/presentation/manager/attendance_bloc.dart';
import 'features/home/data/data_sources/manage_attendance_remote_data_source.dart';
import 'features/home/data/repositories/manage_attendance_repository_impl.dart';
import 'features/home/domain/use_cases/get_all_attendance_use_case.dart';
import 'features/home/presentation/manager/manage_attendance_bloc.dart';
import 'features/login/data/data_sources/auth_data_source.dart';
import 'features/login/data/repositories/auth_repository_impl.dart';
import 'features/login/domain/use_cases/login_checker_use_case.dart';
import 'features/login/domain/use_cases/login_use_case.dart';
import 'features/login/domain/use_cases/logout_use_case.dart';
import 'features/login/presentation/manager/auth_bloc.dart';
import 'features/message/presentation/manager/message_bloc.dart';
import 'features/news/data/data_sources/news_data_source.dart';
import 'features/news/data/repositories/news_repository_impl.dart';
import 'features/news/domain/use_cases/create_news_use_case.dart';
import 'features/news/domain/use_cases/delete_news_use_case.dart';
import 'features/news/domain/use_cases/edit_news_use_case.dart';
import 'features/news/domain/use_cases/get_news_use_case.dart';
import 'features/news/presentation/manager/news_bloc.dart';
import 'features/profile/data/data_sources/profile_data_source.dart';
import 'features/profile/data/repositories/profile_repository_impl.dart';
import 'features/profile/domain/use_cases/add_user_use_case.dart';
import 'features/profile/domain/use_cases/change_password_use_case.dart';
import 'features/profile/domain/use_cases/edit_profile_use_case.dart';
import 'features/profile/domain/use_cases/get_profile_use_case.dart';
import 'features/profile/presentation/manager/profile_bloc.dart';

final getIt = GetIt.instance;

void serviceLocator() async {
  /// Data Sources (bisa local atau remote)
  // Auth
  getIt.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSource());
  //Profile
  getIt.registerLazySingleton<ProfileRemoteDataSource>(
      () => ProfileRemoteDataSource());
  //Attendance
  getIt.registerLazySingleton<AttendanceRemoteDataSource>(
      () => AttendanceRemoteDataSource());
  //News
  getIt.registerLazySingleton<NewsRemoteDataSource>(
      () => NewsRemoteDataSource());
//Manage Attendance
  getIt.registerLazySingleton<ManageAttendanceRemoteDataSource>(
      () => ManageAttendanceRemoteDataSource());

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
  //News
  getIt.registerLazySingleton<NewsRepositoryImpl>(
    () => NewsRepositoryImpl(
      remoteDataSource: getIt<NewsRemoteDataSource>(),
    ),
  );
  //Manage Attendance
  getIt.registerLazySingleton<ManageAttendanceRepositoryImpl>(
    () => ManageAttendanceRepositoryImpl(
      remoteDataSource: getIt<ManageAttendanceRemoteDataSource>(),
    ),
  );

  /// Use Cases (semua use case dimasukkan)
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
  getIt.registerLazySingleton<AddUserUseCase>(
    () => AddUserUseCase(getIt<ProfileRepositoryImpl>()),
  );
  getIt.registerLazySingleton<EditProfileUseCase>(
    () => EditProfileUseCase(getIt<ProfileRepositoryImpl>()),
  );
  getIt.registerLazySingleton<ChangePasswordUseCase>(
    () => ChangePasswordUseCase(getIt<ProfileRepositoryImpl>()),
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
  getIt.registerLazySingleton<GetAttendanceUseCase>(
    () => GetAttendanceUseCase(
      getIt<AttendanceRepositoryImpl>(),
    ),
  );
  //News
  getIt.registerLazySingleton<CreateNewsUseCase>(
    () => CreateNewsUseCase(
      getIt<NewsRepositoryImpl>(),
    ),
  );
  getIt.registerLazySingleton<GetNewsUseCase>(
    () => GetNewsUseCase(
      getIt<NewsRepositoryImpl>(),
    ),
  );
  getIt.registerLazySingleton<EditNewsUseCase>(
    () => EditNewsUseCase(
      getIt<NewsRepositoryImpl>(),
    ),
  );
  getIt.registerLazySingleton<DeleteNewsUseCase>(
    () => DeleteNewsUseCase(
      getIt<NewsRepositoryImpl>(),
    ),
  );
  //Manage Attendance
  getIt.registerLazySingleton<GetAllAttendanceUseCase>(
    () => GetAllAttendanceUseCase(
      getIt<ManageAttendanceRepositoryImpl>(),
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
      addUserUseCase: getIt<AddUserUseCase>(),
      editProfileUseCase: getIt<EditProfileUseCase>(),
      changePasswordUseCase: getIt<ChangePasswordUseCase>(),
    ),
  );
  //Attendance
  getIt.registerFactory<AttendanceBloc>(
    () => AttendanceBloc(
      checkInUseCase: getIt<CheckInUseCase>(),
      checkOutUseCase: getIt<CheckOutUseCase>(),
      attendCheckerUseCase: getIt<AttendCheckerUseCase>(),
      getAttendanceUseCase: getIt<GetAttendanceUseCase>(),
    ),
  );
  //News
  getIt.registerFactory<NewsBloc>(
    () => NewsBloc(
      createNewsUseCase: getIt<CreateNewsUseCase>(),
      getNewsUseCase: getIt<GetNewsUseCase>(),
      editNewsUseCase: getIt<EditNewsUseCase>(),
      deleteNewsUseCase: getIt<DeleteNewsUseCase>(),
    ),
  );
  //Message
  getIt.registerFactory<MessageBloc>(
    () => MessageBloc(),
  );
  //Manage Attendance
  getIt.registerFactory<ManageAttendanceBloc>(
    () => ManageAttendanceBloc(
      getAllAttendanceUseCase: getIt<GetAllAttendanceUseCase>(),
    ),
  );

  /// Outside
}
