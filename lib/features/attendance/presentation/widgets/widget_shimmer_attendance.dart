import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../core/utils/utils.dart';
import '../../../../core/widgets/shimmer_widget.dart';

class WidgetShimmerAttendance {
  ShimmerWidget informationPhotoShimmer() {
    return ShimmerWidget(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: PaletteColor().lightGray,
          ),
          shape: BoxShape.circle,
          color: PaletteColor().white,
        ),
      ),
    );
  }

  Column informationAttendShimmer() {
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
        Gap(24.h),
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
          border: Border.all(color: PaletteColor().softBlack),
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
        color: PaletteColor().softBlack,
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
