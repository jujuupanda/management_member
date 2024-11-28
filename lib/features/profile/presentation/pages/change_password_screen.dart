import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils/utils.dart';
import '../../../../core/widgets/container_body.dart';
import '../../../../core/widgets/page_background.dart';
import '../../../../core/widgets/page_header.dart';
import '../../../../core/widgets/shimmer_widget.dart';
import '../../../../core/widgets/widget_action_button.dart';
import '../manager/profile_bloc.dart';
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
    BlocFunction().initialProfile(context);
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
        BlocFunction().changePassword(
          context,
          oldPasswordC.text,
          newPasswordC.text,
        );
      }
    };
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is ProfileSuccessState) {
          if (state.isLoading == false && state.messageFailed == "" && state.isPasswordChanged == true) {
            PopUpDialog().successDoSomething(
              context,
              "Kata sandi berhasil diubah",
              () {
                context.pop();
                GoRouter.of(context).pop();
              },
            );
          }
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Stack(
          children: [
            const PageBackground(),
            Column(
              children: [
                const PageHeader(
                  isDetail: true,
                ),
                Gap(10.h),
                Expanded(
                  child: ContainerBody(
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
                              WidgetActionButton(
                                name: "Simpan",
                                onTap: changePassword(),
                              ),
                              Gap(30.h),
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
