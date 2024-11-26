import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routes/route_app.dart';
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
          if (state.isLoading == true && state.dataUser != null) {
            final dataUser = state.dataUser!;
            return GestureDetector(
              onTap: () {
                context.pushNamed(
                  RouteName().editProfileInformation,
                );
              },
              child: Column(
                children: [
                  Hero(
                    tag: "profilePicture",
                    child: Container(
                      height: 190.h,
                      width: 190.w,
                      decoration: BoxDecoration(
                        color: PaletteColor().white,
                        shape: BoxShape.circle,
                      ),
                      child: ImageLoader().profileCircle(dataUser),
                    ),
                  ),
                  Gap(12.h),
                  Container(
                    color: PaletteColor().transparent,
                    child: Column(
                      children: [
                        Text(
                          dataUser.fullName,
                          style: StyleText().openSansBigValueWhite,
                        ),
                        Text(
                          dataUser.division,
                          style: StyleText().openSansNormalWhite,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
          if(state.isLoading == true){
            return WidgetShimmerProfile().profileInformationHeaderShimmer();
          }
          final dataUser = state.dataUser!;
          return GestureDetector(
            onTap: () {
              context.pushNamed(
                RouteName().editProfileInformation,
              );
            },
            child: Column(
              children: [
                Hero(
                  tag: "profilePicture",
                  child: Container(
                    height: 190.h,
                    width: 190.w,
                    decoration: BoxDecoration(
                      color: PaletteColor().white,
                      shape: BoxShape.circle,
                    ),
                    child: ImageLoader().profileCircle(dataUser),
                  ),
                ),
                Gap(12.h),
                Container(
                  color: PaletteColor().transparent,
                  child: Column(
                    children: [
                      Text(
                        dataUser.fullName,
                        style: StyleText().openSansBigValueWhite,
                      ),
                      Text(
                        dataUser.division,
                        style: StyleText().openSansNormalWhite,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
        return WidgetShimmerProfile().profileInformationHeaderShimmer();
      },
    );
  }
}
