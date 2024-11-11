import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/utils.dart';

class WidgetLogout extends StatelessWidget {
  const WidgetLogout({
    super.key,
    required this.onTap,
  });

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      width: 350.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(
          color: ColorPalette().redWarning,
        ),
      ),
      child: Material(
        color: ColorPalette().transparent,

        child: InkWell(
          splashColor: ColorPalette().softBlue5,
          onTap: onTap,borderRadius: BorderRadius.circular(24.r),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Icon(
                  Icons.logout,
                  color: ColorPalette().redWarning,
                ),
              ),
              Expanded(
                child: Text(
                  "Keluar",
                  style: StyleText().openSansNormalRed,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
