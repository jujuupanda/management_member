import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'core/services/firebase_service.dart';
import 'core/services/geo_location_service.dart';
import 'features/attendance/presentation/manager/attendance_bloc.dart';
import 'features/login/presentation/manager/auth_bloc.dart';
import 'features/profile/presentation/manager/profile_bloc.dart';
import 'firebase_options.dart';
import 'service_locator.dart';

import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseService().initialFirebaseMessaging();
  GeoLocationService().getCurrentLocation();
  await initializeDateFormatting('id_ID', null);
  runApp(const MyApp());

  serviceLocator();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<AuthBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<ProfileBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<AttendanceBloc>(),
        ),
      ],
      child: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: const App(),
      ),
    );
  }
}
