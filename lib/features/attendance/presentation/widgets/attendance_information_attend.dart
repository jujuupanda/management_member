import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widgets/container_body.dart';
import '../../../../core/widgets/custom_circle_loading.dart';
import '../manager/attendance_bloc.dart';
import 'widget_information_initial.dart';
import 'widget_information_with_data.dart';
import 'widget_shimmer_attendance.dart';

class AttendanceInformationAttend extends StatelessWidget {
  const AttendanceInformationAttend({
    super.key,
    required this.onPhotoCaptured,
    required this.isCaptured,
  });

  final Function(File) onPhotoCaptured;
  final File? isCaptured;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ContainerBody(
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: 20.h,
              horizontal: 12.w,
            ),
            child: BlocBuilder<AttendanceBloc, AttendanceState>(
              builder: (context, state) {
                if (state is AttendancesLoaded) {
                  if (state.isLoading == true) {
                    return WidgetShimmerAttendance().informationAttendShimmer();
                  }
                  if (state.attendToday != null) {
                    return WidgetInformationWithData(
                      attendance: state.attendToday!,
                      onPhotoCaptured: onPhotoCaptured,
                      isCaptured: isCaptured,
                    );
                  }
                  return WidgetInformationInitial(
                    onPhotoCaptured: onPhotoCaptured,
                    isCaptured: isCaptured,
                  );
                }
                return WidgetShimmerAttendance().informationAttendShimmer();
              },
            ),
          ),
        ),
        BlocBuilder<AttendanceBloc, AttendanceState>(
          builder: (context, state) {
            if (state is AttendancesLoaded) {
              if (state.isLoading == true && state.isLoadingCheckIn == true) {
                return const CustomCircleLoading();
              }
            }
            return const SizedBox();
          },
        )
      ],
    );
  }
}
