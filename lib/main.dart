import 'package:flutter/material.dart';
import 'service_locator.dart';

import 'app.dart';

void main() {
  runApp(const MyApp());
  serviceLocator();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: const App(),
    );
  }
}
