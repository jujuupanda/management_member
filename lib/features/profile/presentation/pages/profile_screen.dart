import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routes/route_app.dart';
import '../../../../core/utils/color_palette.dart';
import '../../../../core/utils/style_text.dart';
import '../../../../core/widgets/custom_circle_loading.dart';
import '../../../login/presentation/manager/auth_bloc.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  logoutButton() {
    return () {
      context.read<AuthBloc>().add(LogoutEvent());
    };
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is LogoutSuccess) {
              context.goNamed(RouteName().login);
            }
          },
        ),
      ],
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: ColorPalette().softBlue1,
              ),
            ),
            Column(
              children: [
                SizedBox(
                  height: 70.h,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () {
                          print("object");
                        },
                        icon: Icon(
                          Icons.notifications,
                          color: ColorPalette().white,
                        ),
                      ),
                    ],
                  ),
                ),
                Gap(32.h),
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
                Gap(24.h),
                Expanded(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: ColorPalette().white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(32.r),
                      ),
                    ),
                    child: Column(
                      children: [
                        Gap(24.h),
                        Container(
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
                                child: const Icon(Icons.location_city),
                              ),
                              Expanded(
                                child: Text(
                                  "Tanjung Bintang",
                                  style: StyleText().openSansNormalBlack,
                                ),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.arrow_forward_ios_rounded,
                                ),
                              )
                            ],
                          ),
                        ),
                        Gap(10.h),
                        Container(
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
                                child: const Icon(Icons.location_city),
                              ),
                              Expanded(
                                child: Text(
                                  "Tanjung Bintang",
                                  style: StyleText().openSansNormalBlack,
                                ),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.arrow_forward_ios_rounded,
                                ),
                              )
                            ],
                          ),
                        ),
                        Gap(30.h),
                        GestureDetector(
                          onTap: logoutButton(),
                          child: Container(
                            height: 50.h,
                            width: 350.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24.r),
                              border: Border.all(
                                color: ColorPalette().redWarning,
                              ),
                            ),
                            child: Row(
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 16.w),
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
                      ],
                    ),
                  ),
                ),
              ],
            ),
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                if (state is AuthLoading) {
                  return const CustomCircleLoading();
                }
                return const SizedBox();
              },
            )
          ],
        ),
      ),
    );
  }
}
