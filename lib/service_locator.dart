import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

void serviceLocator() async {
  /// Data Sources

  /// Repositories

  /// Use Cases

  /// Bloc

  /// Outside

  /// SharedPreferences instance & Register
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(sharedPreferences);
  // Firebase
  // FirebaseFirestore
  // getIt.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);
  // getIt.registerLazySingleton<FirebaseService>(() => FirebaseService());
}
