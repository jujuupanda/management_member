import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/attendance/presentation/manager/attendance_bloc.dart';
import '../../features/login/presentation/manager/auth_bloc.dart';
import '../../features/profile/presentation/manager/profile_bloc.dart';

class BlocFunction {
  //get user profile data
  getProfile(BuildContext context) {
    context.read<ProfileBloc>().add(GetProfile());
  }

  logoutButton(BuildContext context) {
    return () {
      context.read<AuthBloc>().add(LogoutEvent());
    };
  }

  checkInButton(BuildContext context) {
    context.read<AttendanceBloc>().add(
          const CheckInEvent(
            "Luring",
            "image path",
            "123123, 321321",
          ),
        );
  }
}
