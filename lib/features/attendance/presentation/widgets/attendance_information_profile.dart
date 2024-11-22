import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../core/utils/utils.dart';
import '../../../profile/presentation/manager/profile_bloc.dart';
import 'widget_shimmer_attendance.dart';

class AttendanceInformationProfile extends StatelessWidget {
  const AttendanceInformationProfile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 12.h,
        horizontal: 24.w,
      ),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: PaletteColor().white,
          borderRadius: BorderRadius.circular(32.r),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              spreadRadius: 3,
              blurRadius: 2,
              offset: const Offset(2, 0), // changes position of shadow
            ),
          ],
        ),
        child: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state is ProfileSuccessState) {
              if(state.isLoading == true){
                return WidgetShimmerAttendance()
                    .attendanceInformationProfileShimmer();
              }
              final dataUser = state.dataUser!;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Gap(24.h),
                  Container(
                    height: 210.h,
                    width: 210.w,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: PaletteColor().softBlack,
                      ),
                      shape: BoxShape.circle,
                      color: PaletteColor().white,
                    ),
                  ),
                  Gap(14.h),
                  Text(
                    dataUser.fullName,
                    style: StyleText().openSansBigValueBlack,
                  ),
                  Text(
                    dataUser.division,
                    style: StyleText().openSansTitleBlack,
                  ),
                  Gap(24.h),
                ],
              );
            }

            return WidgetShimmerAttendance()
                .attendanceInformationProfileShimmer();
          },
        ),
      ),
    );
  }
}
