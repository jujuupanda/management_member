import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../core/utils/utils.dart';
import '../../../../core/widgets/shimmer_widget.dart';

class WidgetShimmerAttendance {
  Column attendanceInformationProfileShimmer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Gap(24.h),
        ShimmerWidget(
          child: Container(
            height: 210.h,
            width: 210.w,
            decoration: BoxDecoration(
              border: Border.all(
                color: PaletteColor().blue1,
              ),
              shape: BoxShape.circle,
              color: PaletteColor().white,
            ),
          ),
        ),
        Gap(14.h),
        ShimmerWidget(
          child: Container(
            height: 25.h,
            width: 250.w,
            decoration: BoxDecoration(
              color: PaletteColor().white,
              borderRadius: BorderRadius.circular(15.r),
            ),
          ),
        ),
        Gap(8.h),
        ShimmerWidget(
          child: Container(
            height: 15.h,
            width: 250.w,
            decoration: BoxDecoration(
              color: PaletteColor().white,
              borderRadius: BorderRadius.circular(15.r),
            ),
          ),
        ),
        Gap(24.h),
      ],
    );
  }

  Column attendanceInformationAttendShimmer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Gap(12.h),
        const ShimmerWidget(child: WidgetAttendanceTimerForShimmer()),
        Gap(12.h),
        const ShimmerWidget(child: WidgetAttendanceBodyForShimmer()),
        const ShimmerWidget(child: WidgetAttendanceBodyForShimmer()),
        const ShimmerWidget(child: WidgetAttendanceBodyForShimmer()),
        const ShimmerWidget(child: WidgetAttendanceBodyForShimmer()),
        const ShimmerWidget(child: WidgetAttendanceBodyForShimmer()),
        Gap(24.h),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ShimmerWidget(child: WidgetAttendanceButtonForShimmer()),
            ShimmerWidget(child: WidgetAttendanceButtonForShimmer()),
          ],
        ),
        Gap(32.h),
      ],
    );
  }
}

class WidgetAttendanceTimerForShimmer extends StatelessWidget {
  const WidgetAttendanceTimerForShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 45.h,
        width: 120.w,
        decoration: BoxDecoration(
          border: Border.all(color: PaletteColor().blue1),
          borderRadius: BorderRadius.circular(12.r),
          color: PaletteColor().white,
        ),
      ),
    );
  }
}

class WidgetAttendanceButtonForShimmer extends StatelessWidget {
  const WidgetAttendanceButtonForShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.h,
      width: 150.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: PaletteColor().blue1,
      ),
    );
  }
}

class WidgetAttendanceBodyForShimmer extends StatelessWidget {
  const WidgetAttendanceBodyForShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.h),
      child: Container(
        height: 28,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color: PaletteColor().white,
        ),
      ),
    );
  }
}
