import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/utils.dart';

class WidgetInformationTimer extends StatelessWidget {
  const WidgetInformationTimer({
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
        ),
        child: Center(
          child: Text(
            "${DateTime.now().hour.toString()} : ${DateTime.now().minute.toString()}",
            style: StyleText().openSansBigValueBlack,
          ),
        ),
      ),
    );
  }
}
