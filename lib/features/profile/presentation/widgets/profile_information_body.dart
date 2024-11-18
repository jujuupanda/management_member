import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../core/utils/parsing_string.dart';
import '../../../../core/utils/utils.dart';
import '../manager/profile_bloc.dart';
import 'widget_information_body.dart';
import 'widget_logout.dart';
import 'widget_shimmer_profile.dart';

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
        color: PaletteColor().white,
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
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileSuccessState) {
            if(state.isLoading == true){
              return WidgetShimmerProfile().profileInformationBodyShimmer();
            }
            final dataUser = state.dataUser!;
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              child: Column(
                children: [
                  Gap(24.h),
                  WidgetInformationBody(
                    iconData: Icons.perm_contact_cal_outlined,
                    name: "Nama Pengguna",
                    value: dataUser.username,
                    onTap: () {},
                  ),
                  Gap(10.h),
                  WidgetInformationBody(
                    iconData: Icons.email_outlined,
                    name: "Email",
                    value: dataUser.email,
                    onTap: () {},
                  ),
                  Gap(10.h),
                  WidgetInformationBody(
                    iconData: Icons.phone_outlined,
                    name: "Telepon",
                    value: dataUser.phone,
                    onTap: () {},
                  ),
                  Gap(10.h),
                  WidgetInformationBody(
                    iconData: Icons.location_on_outlined,
                    name: "Alamat",
                    value: dataUser.address,
                    onTap: () {},
                  ),
                  Gap(10.h),
                  WidgetInformationBody(
                    iconData: Icons.money,
                    name: "Gaji",
                    value:
                        "Rp. ${ParsingString().formatCurrency(dataUser.salary)}",
                    onTap: () {},
                  ),
                  Gap(10.h),
                  WidgetInformationBody(
                    iconData: Icons.lock_outline,
                    name: "Kata Sandi",
                    value: "Ubah Kata Sandi",
                    onTap: () {},
                  ),
                  Gap(30.h),
                  WidgetLogout(onTap: onTap),
                ],
              ),
            );
          }
          return WidgetShimmerProfile().profileInformationBodyShimmer();
        },
      ),
    );
  }
}
