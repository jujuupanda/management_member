import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../core/utils/utils.dart';

class WidgetAttendanceRecap extends StatelessWidget {
  const WidgetAttendanceRecap({
    super.key,
    required this.name,
    required this.value,
    required this.identifiedAs,
  });

  final String name;
  final String value;
  final String identifiedAs;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140.h,
      width: 120.w,
      decoration: BoxDecoration(
        color: PaletteColor().white,
        border: Border.all(color: PaletteColor().softBlue1),
        borderRadius: BorderRadius.circular(8.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 2,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 70.h,
            width: 70.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: circleColor(),
            ),
            child: Center(
              child: Text(
                value,
                style: StyleText().openSansBigValueWhite,
              ),
            ),
          ),
          Gap(10.h),
          Text(
            name,
            style: StyleText().openSansTitleBlack,
          ),
        ],
      ),
    );
  }

  circleColor() {
    if (identifiedAs == "present") {
      return PaletteColor().greenPresence;
    }
    if (identifiedAs == "late") {
      return PaletteColor().yellowPresence;
    }
    if (identifiedAs == "absent") {
      return PaletteColor().redPresence;
    }
  }
}
