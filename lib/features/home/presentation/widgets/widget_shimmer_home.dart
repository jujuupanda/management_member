import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import '../../../../core/utils/utils.dart';
import '../../../../core/widgets/shimmer_widget.dart';
import 'widget_attendance_recap.dart';

class WidgetShimmerHome {
  homeScreenShimmer(BuildContext context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShimmerWidget(
          child: Container(
            height: 50,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: PaletteColor().white,
              border: Border.all(color: PaletteColor().lightGray),
              borderRadius: BorderRadius.circular(8.r),
            ),
          ),
        ),
        Gap(10.h),
        ShimmerWidget(
          child: Container(
            height: 300,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: PaletteColor().white,
              border: Border.all(color: PaletteColor().lightGray),
              borderRadius: BorderRadius.circular(8.r),
            ),
          ),
        ),
        Gap(10.h),
        ShimmerWidget(
          child: Container(
            height: 50,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: PaletteColor().white,
              border: Border.all(color: PaletteColor().lightGray),
              borderRadius: BorderRadius.circular(8.r),
            ),
          ),
        ),
        Gap(10.h),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ShimmerWidget(
              child: WidgetAttendanceRecap(
                name: "",
                value: "",
                identifiedAs: "present",
              ),
            ),
            ShimmerWidget(
              child: WidgetAttendanceRecap(
                name: "",
                value: "",
                identifiedAs: "late",
              ),
            ),
            ShimmerWidget(
              child: WidgetAttendanceRecap(
                name: "",
                value: "",
                identifiedAs: "absent",
              ),
            ),
          ],
        ),
        Gap(20.h),
        ShimmerWidget(
          child: Container(
            height: 50,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: PaletteColor().white,
              border: Border.all(color: PaletteColor().lightGray),
              borderRadius: BorderRadius.circular(8.r),
            ),
          ),
        ),
        Gap(10.h),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ShimmerWidget(
              child: WidgetAttendanceRecap(
                name: "",
                value: "",
                identifiedAs: "present",
              ),
            ),
            ShimmerWidget(
              child: WidgetAttendanceRecap(
                name: "",
                value: "",
                identifiedAs: "late",
              ),
            ),
            ShimmerWidget(
              child: WidgetAttendanceRecap(
                name: "",
                value: "",
                identifiedAs: "absent",
              ),
            ),
          ],
        ),
        Gap(20.h),
        ShimmerWidget(
          child: Container(
            height: 50,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: PaletteColor().white,
              border: Border.all(color: PaletteColor().lightGray),
              borderRadius: BorderRadius.circular(8.r),
            ),
          ),
        ),
      ],
    );
  }
}