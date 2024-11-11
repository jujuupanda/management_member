import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/utils.dart';

class WidgetInformationBody extends StatelessWidget {
  const WidgetInformationBody({
    super.key,
    required this.iconData,
    required this.name,
    required this.onTap,
  });

  final String name;
  final VoidCallback onTap;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      width: 350.w,
      decoration: BoxDecoration(
        color: ColorPalette().grayToWhite,
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Icon(iconData),
          ),
          Expanded(
            child: Text(
              name,
              style: StyleText().openSansNormalBlack,
            ),
          ),
          IconButton(
            onPressed: onTap,
            icon: const Icon(
              Icons.arrow_forward_ios_rounded,
            ),
          )
        ],
      ),
    );
  }
}
