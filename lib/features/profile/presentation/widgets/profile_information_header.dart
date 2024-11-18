import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../core/utils/utils.dart';
import '../manager/profile_bloc.dart';
import 'widget_shimmer_profile.dart';

class ProfileInformationHeader extends StatelessWidget {
  const ProfileInformationHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileSuccessState) {
          if(state.isLoading == true){
            return WidgetShimmerProfile().profileInformationHeaderShimmer();
          }
          final dataUser = state.dataUser!;
          return Column(
            children: [
              Container(
                height: 120.h,
                width: 120.w,
                decoration: BoxDecoration(
                  color: PaletteColor().white,
                  shape: BoxShape.circle,
                ),
              ),
              Gap(12.h),
              Text(
                dataUser.fullName,
                style: StyleText().openSansBigValueWhite,
              ),
              Text(
                dataUser.division,
                style: StyleText().openSansNormalWhite,
              ),
            ],
          );
        }
        return WidgetShimmerProfile().profileInformationHeaderShimmer();
      },
    );
  }
}
