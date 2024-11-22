import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routes/route_app.dart';
import '../../../../core/utils/bloc_function.dart';
import '../../../../core/utils/utils.dart';
import '../../../../core/widgets/page_background.dart';
import '../../../../core/widgets/page_header.dart';
import '../manager/profile_bloc.dart';
import '../widgets/widget_dialog_edit.dart';

class EditProfileInformationScreen extends StatefulWidget {
  const EditProfileInformationScreen({super.key});

  @override
  State<EditProfileInformationScreen> createState() =>
      _EditProfileInformationScreenState();
}

class _EditProfileInformationScreenState
    extends State<EditProfileInformationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const PageBackground(),
          BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              if (state is ProfileSuccessState) {
                if (state.isLoading == true) {
                  final dataUser = state.dataUser!;
                  return Column(
                    children: [
                      const PageHeader(
                        isDetail: true,
                      ),
                      Gap(20.h),
                      GestureDetector(
                        onTap: () {
                          context.pushNamed(RouteName().changeProfilePictureScreen);
                        },
                        child: Hero(
                          tag: "profilePicture",
                          child: Container(
                            height: 250.h,
                            width: 250.w,
                            decoration: BoxDecoration(
                              color: PaletteColor().white,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ),
                      Gap(20.h),
                      EditProfileWidget(
                        name: "Nama Lengkap",
                        value: dataUser.fullName,
                        iconData: Icons.contact_mail_outlined,
                        onTap: () {},
                      ),
                      customDivider(),
                      EditProfileWidget(
                        name: "Divisi",
                        value: dataUser.division,
                        iconData: Icons.corporate_fare_outlined,
                        onTap: () {},
                      ),
                    ],
                  );
                }
                final dataUser = state.dataUser!;
                return Column(
                  children: [
                    const PageHeader(
                      isDetail: true,
                    ),
                    Gap(20.h),
                    GestureDetector(
                      onTap: () {
                        context.pushNamed(RouteName().changeProfilePictureScreen);
                      },
                      child: Hero(
                        tag: "profilePicture",
                        child: Container(
                          height: 250.h,
                          width: 250.w,
                          decoration: BoxDecoration(
                            color: PaletteColor().white,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ),
                    Gap(20.h),
                    EditProfileWidget(
                      name: "Nama Lengkap",
                      value: dataUser.fullName,
                      iconData: Icons.contact_mail_outlined,
                      onTap: () {
                        WidgetDialogEdit().showFormDialog(
                          context,
                          "Nama Lengkap",
                          dataUser.fullName,
                          "Masukkan nama lengkap",
                          "onlyText",
                          Icons.contact_mail_outlined,
                          (valueChanged) {
                            BlocFunction().editProfile(
                              context,
                              dataUser,
                              {
                                "full_name": valueChanged,
                              },
                            );
                          },
                        );
                      },
                    ),
                    customDivider(),
                    EditProfileWidget(
                      name: "Divisi",
                      value: dataUser.division,
                      iconData: Icons.corporate_fare_outlined,
                      onTap: () {
                        WidgetDialogEdit().showFormDialog(
                          context,
                          "Divisi",
                          dataUser.division,
                          "Masukkan divisi",
                          "onlyText",
                          Icons.corporate_fare_outlined,
                          (valueChanged) {
                            BlocFunction().editProfile(
                              context,
                              dataUser,
                              {
                                "division": valueChanged,
                              },
                            );
                          },
                        );
                      },
                    ),
                  ],
                );
              }
              return const SizedBox();
            },
          ),
        ],
      ),
    );
  }

  Row customDivider() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(width: 75.w, color: Colors.transparent),
        Expanded(
          child: Divider(height: 1.h, color: PaletteColor().white),
        ),
      ],
    );
  }
}

class EditProfileWidget extends StatelessWidget {
  const EditProfileWidget({
    super.key,
    required this.name,
    required this.value,
    required this.iconData,
    required this.onTap,
  });

  final String name;
  final String value;
  final IconData iconData;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: PaletteColor().transparent,
      child: InkWell(
        onTap: onTap,
        splashColor: PaletteColor().softGray,
        child: Container(
          color: PaletteColor().transparent,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 8.w,
              vertical: 12.h,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 70.w,
                  color: Colors.transparent,
                  child: Icon(
                    iconData,
                    color: PaletteColor().white,
                    size: 30,
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: StyleText().openSansNormalWhite,
                      ),
                      Text(
                        value,
                        style: StyleText().openSansTitleWhite,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: null,
                  icon: Icon(
                    Icons.edit,
                    color: PaletteColor().white,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}