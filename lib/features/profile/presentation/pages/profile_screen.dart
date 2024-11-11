import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routes/route_app.dart';
import '../../../../core/widgets/custom_circle_loading.dart';
import '../../../login/presentation/manager/auth_bloc.dart';
import '../widgets/profile_background.dart';
import '../widgets/profile_header.dart';
import '../widgets/profile_information_body.dart';
import '../widgets/profile_information_header.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  logoutButton() {
    return () {
      context.read<AuthBloc>().add(LogoutEvent());
    };
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is LogoutSuccess) {
              context.goNamed(RouteName().login);
            }
          },
        ),
      ],
      child: Scaffold(
        body: Stack(
          children: [
            const ProfileBackground(),
            Column(
              children: [
                const ProfileHeader(),
                Gap(32.h),
                const ProfileInformationHeader(),
                Gap(24.h),
                Expanded(
                  child: ProfileInformationBody(
                    onTap: logoutButton(),
                  ),
                ),
              ],
            ),
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                if (state is AuthLoading) {
                  return const CustomCircleLoading();
                }
                return const SizedBox();
              },
            )
          ],
        ),
      ),
    );
  }
}
