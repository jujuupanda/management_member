import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import '../../../../core/widgets/shimmer_widget.dart';

import '../../../../core/utils/utils.dart';
import 'widget_information_body.dart';

class WidgetShimmerProfile {
  Column profileInformationHeaderShimmer() {
    return Column(
      children: [
        ShimmerWidget(
          child: Container(
            height: 190.h,
            width: 190.w,
            decoration: BoxDecoration(
              color: PaletteColor().white,
              shape: BoxShape.circle,
            ),
          ),
        ),
        Gap(12.h),
        ShimmerWidget(
          child: Container(
            height: 25.h,
            width: 250.w,
            decoration: BoxDecoration(
              color: PaletteColor().white,
              borderRadius: BorderRadius.circular(15.r),
            ),
          ),
        ),
        Gap(4.h),
        ShimmerWidget(
          child: Container(
            height: 15.h,
            width: 250.w,
            decoration: BoxDecoration(
              color: PaletteColor().white,
              borderRadius: BorderRadius.circular(15.r),
            ),
          ),
        ),
      ],
    );
  }

  SingleChildScrollView profileInformationBodyShimmer() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      physics: const AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          Gap(24.h),
          ShimmerWidget(
            child: WidgetInformationBody(
              iconData: Icons.lock_outline,
              name: "Kata Sandi",
              value: "",
              onTap: () {},
            ),
          ),
          Gap(10.h),
          ShimmerWidget(
            child: WidgetInformationBody(
              iconData: Icons.perm_contact_cal_outlined,
              name: "Nama Pengguna",
              value: "",
              onTap: () {},
            ),
          ),
          Gap(10.h),
          ShimmerWidget(
            child: WidgetInformationBody(
              iconData: Icons.email_outlined,
              name: "Email",
              value: "",
              onTap: () {},
            ),
          ),
          Gap(10.h),
          ShimmerWidget(
            child: WidgetInformationBody(
              iconData: Icons.phone_outlined,
              name: "Telepon",
              value: "",
              onTap: () {},
            ),
          ),
          Gap(10.h),
          ShimmerWidget(
            child: WidgetInformationBody(
              iconData: Icons.location_on_outlined,
              name: "Alamat",
              value: "",
              onTap: () {},
            ),
          ),
          Gap(10.h),
          ShimmerWidget(
            child: WidgetInformationBody(
              iconData: Icons.money,
              name: "Gaji",
              value: "",
              onTap: () {},
            ),
          ),
          Gap(30.h),
          ShimmerWidget(
            child: WidgetInformationBody(
              iconData: Icons.logout,
              name: "Logout",
              value: "",
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }
}
