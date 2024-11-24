import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/utils.dart';
import '../manager/attendance_bloc.dart';
import 'widget_information_initial.dart';
import 'widget_information_with_data.dart';
import 'widget_shimmer_attendance.dart';

class AttendanceInformationAttend extends StatelessWidget {
  const AttendanceInformationAttend({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: PaletteColor().white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(32.r),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 2,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 20.h,
          horizontal: 12.w,
        ),
        child: BlocBuilder<AttendanceBloc, AttendanceState>(
          builder: (context, state) {
            if (state is GetAttendanceSuccess) {
              if (state.isLoading == true) {
                return WidgetShimmerAttendance()
                    .attendanceInformationAttendShimmer();
              }
              if (state.isLoading == false && state.attendToday != null) {

                return WidgetInformationWithData(
                    attendance: state.attendToday!);
              }
              if (state.isLoading == false && state.attendToday == null) {

                return const WidgetInformationInitial();

              }
            }
            return WidgetShimmerAttendance()
                .attendanceInformationAttendShimmer();
          },
        ),
      ),
    );
  }
}
