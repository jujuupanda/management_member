import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/utils.dart';

class WidgetButtonAttendance extends StatelessWidget {
  const WidgetButtonAttendance({
    super.key,
    required this.name,
    required this.onTap,
    this.isActive = false,
  });

  final String name;
  final VoidCallback onTap;
  final bool? isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.h,
      width: 150.w,
      decoration: boxDecoration(),
      child: Material(
        color: PaletteColor().transparent,
        child: InkWell(
          onTap: onTapFunc(),
          borderRadius: BorderRadius.circular(12.r),
          splashColor: PaletteColor().grayToWhite,
          child: Center(
            child: Text(
              name,
              style: style(),
            ),
          ),
        ),
      ),
    );
  }

  onTapFunc() {
    if (isActive == true) {
      return onTap;
    } else {
      return null;
    }
  }

  boxDecoration() {
    if (isActive == true) {
      return BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: PaletteColor().softBlack,
        border: Border.all(
          color: PaletteColor().softBlack,
        ),
      );
    } else {
      return BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: PaletteColor().white,
        border: Border.all(
          color: PaletteColor().softBlue1,
        ),
      );
    }
  }

  style() {
    if (isActive == true) {
      return StyleText().openSansTitleWhite;
    } else {
      return StyleText().openSansTitleSoftBlue1;
    }
  }
}
