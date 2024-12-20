import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/routes/route_app.dart';
import '../../../../core/widgets/container_body.dart';
import 'widget_shimmer_attendance.dart';

import '../../../../core/utils/utils.dart';
import '../manager/attendance_bloc.dart';

class AttendanceInformationPhoto extends StatelessWidget {
  const AttendanceInformationPhoto({
    super.key,
    required this.photo,
  });

  final File? photo;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 12.h,
        horizontal: 24.w,
      ),
      child: ContainerBody(
        height: 320,
        roundedAll: true,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 20.w,
            vertical: 20.h,
          ),
          child: GestureDetector(
            onTap: () => context.pushNamed(
              RouteName().attendancePictureScreen,
              extra: photo,
            ),
            child: Hero(
              tag: "attendancePicture",
              child: BlocBuilder<AttendanceBloc, AttendanceState>(
                builder: (context, state) {
                  if (state is AttendancesLoaded) {
                    if (state.isLoading == true) {
                      return WidgetShimmerAttendance()
                          .informationPhotoShimmer();
                    }
                    if (state.attendToday != null) {
                      return withImage(
                          ImageLoader().attendanceCircle(state.attendToday!));
                    }
                    return noImage();
                  }
                  return WidgetShimmerAttendance().informationPhotoShimmer();
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container noImage() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: PaletteColor().lightGray,
        ),
        shape: BoxShape.circle,
        color: PaletteColor().white,
      ),
      child: CircleAvatar(
        backgroundImage: photo != null
            ? FileImage(photo!)
            : AssetImage(NamedString().noProfilePicture),
      ),
    );
  }

  Container withImage(Widget widget) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: PaletteColor().lightGray,
        ),
        shape: BoxShape.circle,
        color: PaletteColor().white,
      ),
      child: widget,
    );
  }
}
