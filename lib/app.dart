import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'core/routes/route_app.dart';
import 'core/utils/color_palette.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(411, 866),
      minTextAdapt: true,
      child: MaterialApp.router(
        routerConfig: routerApp,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: ColorPalette().white,
          textTheme: TextTheme(
            bodyLarge: GoogleFonts.openSans(color: ColorPalette().black),
          ),
        ),
      ),
    );
  }
}
