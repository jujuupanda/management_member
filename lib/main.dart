import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'core/services/database_service.dart';
import 'core/services/geo_location_service.dart';
import 'features/attendance/presentation/manager/attendance_bloc.dart';
import 'features/login/presentation/manager/auth_bloc.dart';
import 'features/message/presentation/manager/message_bloc.dart';
import 'features/news/presentation/manager/news_bloc.dart';
import 'features/profile/presentation/manager/profile_bloc.dart';
import 'firebase_options.dart';
import 'service_locator.dart';

import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Supabase.initialize(
    url: 'https://npbfyuftzsgsrmxdfuph.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im5wYmZ5dWZ0enNnc3JteGRmdXBoIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzE0MDUxMzIsImV4cCI6MjA0Njk4MTEzMn0.l0gLUev3x01pKTdKAUX_Y21_Y_XBI61dAxeGBVUu9Tc',
  );
  await DatabaseService().initialFirebaseMessaging();
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
        BlocProvider(
          create: (context) => getIt<NewsBloc>(),
        ),
        BlocProvider(
          create: (context) =>  getIt<MessageBloc>(),
        ),
      ],
      child: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: const App(),
      ),
    );
  }
}
