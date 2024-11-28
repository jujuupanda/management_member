import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routes/route_app.dart';
import '../../../../core/utils/utils.dart';
import '../../../login/presentation/manager/auth_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  splashTime() {
    Future.delayed(
      const Duration(seconds: 1, milliseconds: 500),
      () {
        BlocProvider.of<AuthBloc>(context).add(
          LoginCheckerEvent(),
        );
      },
    );
  }

  @override
  void initState() {
    splashTime();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is IsAuth) {
          context.goNamed(RouteName().home);
        }
        if (state is UnAuth) {
          context.goNamed(RouteName().login);
        }
      },
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.work,
                size: 130,
                color: PaletteColor().softBlack,
              ),
              Text(
                "Manajemen Anggota",
                style: StyleText().openSansTitleBlack,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
