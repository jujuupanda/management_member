import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../core/utils/bloc_function.dart';
import '../../../../core/utils/utils.dart';
import '../manager/attendance_bloc.dart';
import 'widget_button_attendance.dart';
import 'widget_information_timer.dart';
import 'widget_information_attend.dart';
import 'widget_shimmer_attendance.dart';

class AttendanceInformationAttend extends StatelessWidget {
  const AttendanceInformationAttend({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: PaletteColor().white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(32.r),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              spreadRadius: 3,
              blurRadius: 2,
              offset: const Offset(2, 0), // changes position of shadow
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 12.h,
            horizontal: 12.w,
          ),
          child: BlocBuilder<AttendanceBloc, AttendanceState>(
            builder: (context, state) {
              if (state is AttendanceLoading) {
                return WidgetShimmerAttendance()
                    .attendanceInformationAttendShimmer();
              }
              if (state is AttendanceInitial) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Gap(12.h),
                    const WidgetInformationTimer(),
                    Gap(12.h),
                    const WidgetInformationAttend(
                      informationName: "Jam Kerja",
                      informationValue: "08:00 s/d 17:00",
                      title: true,
                    ),
                    const WidgetInformationAttend(
                      informationName: "Sistem Kerja",
                      informationValue: "-",
                    ),
                    const WidgetInformationAttend(
                      informationName: "Lokasi",
                      informationValue: "-",
                    ),
                    const WidgetInformationAttend(
                      informationName: "Waktu Masuk",
                      informationValue: "-",
                    ),
                    const WidgetInformationAttend(
                      informationName: "Waktu Keluar",
                      informationValue: "-",
                    ),
                    Gap(24.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        WidgetButtonAttendance(
                          name: "Masuk",
                          onTap: () {
                            BlocFunction().checkInButton(context);
                          },
                          isActive: true,
                        ),
                        WidgetButtonAttendance(
                          name: "Keluar",
                          onTap: () {
                            print("object");
                          },
                        ),
                      ],
                    ),
                  ],
                );
              }
              if (state is CheckInSuccess) {
                final checkedIn = state.attendance;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Gap(12.h),
                    const WidgetInformationTimer(),
                    Gap(12.h),
                    const WidgetInformationAttend(
                      informationName: "Jam Kerja",
                      informationValue: "08:00 s/d 17:00",
                      title: true,
                    ),
                    WidgetInformationAttend(
                      informationName: "Sistem Kerja",
                      informationValue: checkedIn.attendToday.typeAttend,
                    ),
                    WidgetInformationAttend(
                      informationName: "Lokasi",
                      informationValue: checkedIn.attendToday.location,
                    ),
                    WidgetInformationAttend(
                      informationName: "Waktu Masuk",
                      informationValue: checkedIn.attendToday.checkIn,
                    ),
                    WidgetInformationAttend(
                      informationName: "Waktu Keluar",
                      informationValue: checkedIn.attendToday.checkOut,
                    ),
                    Gap(24.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        WidgetButtonAttendance(
                          name: "Masuk",
                          onTap: () {
                            BlocFunction().checkInButton(context);
                          },
                        ),
                        WidgetButtonAttendance(
                          name: "Keluar",
                          onTap: () {
                            print("object");
                          },
                          isActive: true,
                        ),
                      ],
                    ),
                  ],
                );
              }
              return WidgetShimmerAttendance()
                  .attendanceInformationAttendShimmer();
            },
          ),
        ),
      ),
    );
  }
}
