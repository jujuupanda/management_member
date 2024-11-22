import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/attendance/presentation/manager/attendance_bloc.dart';
import '../../features/login/presentation/manager/auth_bloc.dart';
import '../../features/profile/domain/entities/user_entity.dart';
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

  checkInButton(
    BuildContext context,
    String attendType,
    String imagePath,
    String location,
  ) {
    context.read<AttendanceBloc>().add(
          CheckInEvent(
            attendType,
            imagePath,
            location,
          ),
        );
  }

  checkOutButton(BuildContext context) {
    context.read<AttendanceBloc>().add(CheckOutEvent());
  }

  attendChecker(BuildContext context) {
    context.read<AttendanceBloc>().add(AttendCheckerEvent());
  }

  getAttendance(BuildContext context) {
    context.read<AttendanceBloc>().add(GetAttendanceEvent());
  }

  addUser(
    BuildContext context,
    String username,
    String password,
    String role,
    String fullName,
    String division,
    String phone,
    String activeWork,
  ) {
    context.read<ProfileBloc>().add(
          AddUser(
            username,
            password,
            role,
            fullName,
            division,
            phone,
            activeWork,
          ),
        );
  }

  editProfile(
    BuildContext context,
    UserEntity user,
    Map<String, dynamic> object,
  ) {
    context.read<ProfileBloc>().add(
          EditProfile(
            user,
            object,
          ),
        );
  }

  initialProfile(BuildContext context) {
    context.read<ProfileBloc>().add(InitialProfile());
  }
}
