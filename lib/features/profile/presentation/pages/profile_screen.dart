import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routes/route_app.dart';
import '../../../../core/utils/bloc_function.dart';
import '../../../../core/widgets/custom_circle_loading.dart';
import '../../../../core/widgets/page_header.dart';
import '../../../login/presentation/manager/auth_bloc.dart';
import '../../../../core/widgets/page_background.dart';
import '../widgets/profile_information_body.dart';
import '../widgets/profile_information_header.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    BlocFunction().getProfile(context);
    super.initState();
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
            const PageBackground(),
            Column(
              children: [
                const PageHeader(
                  isAdmin: true,
                ),
                Gap(32.h),
                const ProfileInformationHeader(),
                Gap(32.h),
                const Expanded(child: ProfileInformationBody()),
              ],
            ),
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                if (state is AuthLoading) {
                  return const CustomCircleLoading();
                }
                return const SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }
}
