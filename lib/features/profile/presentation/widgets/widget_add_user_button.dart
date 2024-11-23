import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/utils.dart';

class WidgetActionProfileButton extends StatelessWidget {
  const WidgetActionProfileButton({
    super.key,
    required this.onTap,
    required this.name,
  });

  final VoidCallback onTap;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.h,
      width: 150.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        color: PaletteColor().softBlack,
      ),
      child: Material(
        color: PaletteColor().transparent,
        child: InkWell(
          onTap: onTap,
          splashColor: PaletteColor().lightGray,
          borderRadius: BorderRadius.circular(16.r),
          child: Center(
            child: Text(
              name,
              style: StyleText().openSansTitleWhite,
            ),
          ),
        ),
      ),
    );
  }
}
