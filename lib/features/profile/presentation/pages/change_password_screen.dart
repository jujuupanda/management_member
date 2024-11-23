import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../core/utils/utils.dart';
import '../../../../core/widgets/page_background.dart';
import '../../../../core/widgets/page_header.dart';
import '../../../../core/widgets/shimmer_widget.dart';
import '../manager/profile_bloc.dart';
import '../widgets/widget_add_user_button.dart';
import '../widgets/widget_text_form_field_edit_password.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController oldPasswordC;
  late TextEditingController newPasswordC;
  late TextEditingController confirmNewPasswordC;

  @override
  void initState() {
    super.initState();
    oldPasswordC = TextEditingController();
    newPasswordC = TextEditingController();
    confirmNewPasswordC = TextEditingController();
  }

  @override
  void dispose() {
    oldPasswordC.dispose();
    newPasswordC.dispose();
    confirmNewPasswordC.dispose();
    super.dispose();
  }

  changePassword() {
    return () {
      if (formKey.currentState!.validate()) {
      }
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          const PageBackground(),
          Column(
            children: [
              const PageHeader(
                isDetail: true,
              ),
              Gap(18.h),
              Expanded(
                child: Container(
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
                        offset:
                            const Offset(2, 0), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 32.h,
                      horizontal: 24.w,
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Form(
                        key: formKey,
                        child: Column(
                          children: [
                            Gap(12.h),
                            Text(
                              "Ubah Kata Sandi",
                              style: StyleText().openSansTitleBlack,
                            ),
                            Gap(18.h),
                            WidgetTextFormFieldEditPassword(
                              controller: oldPasswordC,
                              labelText: "Kata Sandi Lama",
                              hintText: "Masukkan kata sandi lama",
                              identifiedAs: "oldPassword",
                              iconData: Icons.lock,
                            ),
                            WidgetTextFormFieldEditPassword(
                              controller: newPasswordC,
                              labelText: "Kata Sandi Baru",
                              hintText: "Masukkan kata sandi baru",
                              identifiedAs: "newPassword",
                              iconData: Icons.lock,
                            ),
                            WidgetTextFormFieldEditPassword(
                              controller: confirmNewPasswordC,
                              anotherController: newPasswordC,
                              labelText: "Konfirmasi Kata Sandi Baru",
                              hintText: "Masukkan kata sandi baru",
                              identifiedAs: "confirmNewPassword",
                              iconData: Icons.lock,
                            ),
                            Gap(12.h),
                            loadingWidget(),
                            Gap(12.h),
                            WidgetActionProfileButton(
                              name: "Simpan",
                              onTap: changePassword(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  BlocBuilder<ProfileBloc, ProfileState> loadingWidget() {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileSuccessState) {
          if (state.isLoading == true) {
            return ShimmerWidget(
              child: Container(
                height: 24.h,
                decoration: BoxDecoration(
                  color: PaletteColor().white,
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
            );
          }
          if (state.messageFailed != null) {
            return SizedBox(
              height: 24.h,
              child: Center(
                child: Text(
                  state.messageFailed!,
                  style: StyleText().openSansNormalRed,
                ),
              ),
            );
          }
        }
        return Gap(24.h);
      },
    );
  }
}
