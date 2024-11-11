import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../core/utils/utils.dart';
import 'widget_information_body.dart';
import 'widget_logout.dart';

class ProfileInformationBody extends StatelessWidget {
  const ProfileInformationBody({
    super.key,
    required this.onTap,
  });

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: ColorPalette().white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(32.r),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            spreadRadius: 3,
            blurRadius: 2,
            offset: const Offset(2, 0), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        children: [
          Gap(24.h),
          WidgetInformationBody(
            iconData: Icons.perm_contact_cal_outlined,
            name: "Nama Pengguna",
            onTap: () {},
          ),
          Gap(10.h),
          WidgetInformationBody(
            iconData: Icons.lock_outline,
            name: "Kata Sandi",
            onTap: () {},
          ),
          Gap(10.h),
          WidgetInformationBody(
            iconData: Icons.email_outlined,
            name: "Email",
            onTap: () {},
          ),
          Gap(10.h),
          WidgetInformationBody(
            iconData: Icons.phone_outlined,
            name: "Telepon",
            onTap: () {},
          ),
          Gap(10.h),
          WidgetInformationBody(
            iconData: Icons.location_on_outlined,
            name: "Alamat",
            onTap: () {},
          ),
          Gap(10.h),
          WidgetInformationBody(
            iconData: Icons.money,
            name: "Gaji",
            onTap: () {},
          ),
          Gap(30.h),
          WidgetLogout(onTap: onTap),
        ],
      ),
    );
  }
}
