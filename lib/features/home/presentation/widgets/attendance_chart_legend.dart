import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../core/utils/utils.dart';

class AttendChartLegend extends StatelessWidget {
  const AttendChartLegend({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 8.h,
        horizontal: 8.w,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: 10.h,
                width: 10.w,
                color: PaletteColor().greenPresence,
              ),
              Gap(4.w),
              Text(
                "Hadir",
                style:
                StyleText().openSansSmallBlack,
              ),
            ],
          ),
          Row(
            children: [
              Container(
                height: 10.h,
                width: 10.w,
                color: PaletteColor().yellowPresence,
              ),
              Gap(4.w),
              Text(
                "Terlambat",
                style:
                StyleText().openSansSmallBlack,
              ),
            ],
          ),
          Row(
            children: [
              Container(
                height: 10.h,
                width: 10.w,
                color: PaletteColor().redPresence,
              ),
              Gap(4.w),
              Text(
                "Tidak Hadir",
                style:
                StyleText().openSansSmallBlack,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
