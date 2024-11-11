import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../core/utils/utils.dart';


class ProfileInformationHeader extends StatelessWidget {
  const ProfileInformationHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 120.h,
          width: 120.w,
          decoration: BoxDecoration(
            color: ColorPalette().white,
            shape: BoxShape.circle,
          ),
        ),
        Gap(12.h),
        Text(
          "Nama Pengguna",
          style: StyleText().openSansBigValueWhite,
        ),
        Text(
          "Mobile Developer",
          style: StyleText().openSansNormalWhite,
        ),
      ],
    );
  }
}
