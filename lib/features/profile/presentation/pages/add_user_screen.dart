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
import '../widgets/widget_text_form_field_add_user.dart';

class AddUserScreen extends StatefulWidget {
  const AddUserScreen({super.key});

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  late TextEditingController fullNameC;
  late TextEditingController usernameC;
  late TextEditingController divisionC;
  late TextEditingController phoneC;
  late TextEditingController passwordC;
  late TextEditingController confirmPasswordC;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    BlocFunction().initialProfile(context);
    fullNameC = TextEditingController();
    usernameC = TextEditingController();
    divisionC = TextEditingController();
    phoneC = TextEditingController();
    passwordC = TextEditingController();
    confirmPasswordC = TextEditingController();
  }

  @override
  void dispose() {
    fullNameC.dispose();
    usernameC.dispose();
    divisionC.dispose();
    phoneC.dispose();
    passwordC.dispose();
    confirmPasswordC.dispose();
    super.dispose();
  }

  addUserButton() {
    return () {
      if (formKey.currentState!.validate()) {
        BlocFunction().addUser(
          context,
          usernameC.text,
          passwordC.text,
          "user",
          fullNameC.text,
          divisionC.text,
          phoneC.text,
          DateTime.now().toString(),
        );
      }
    };
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is ProfileSuccessState) {
          if (state.isLoading == false && state.messageFailed == "") {
            fullNameC.clear();
            usernameC.clear();
            divisionC.clear();
            phoneC.clear();
            passwordC.clear();
            confirmPasswordC.clear();
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
                                "Tambah Pengguna",
                                style: StyleText().openSansTitleBlack,
                              ),
                              Gap(18.h),
                              WidgetTextFormFieldAddUser(
                                controller: fullNameC,
                                labelText: "Nama Lengkap",
                                hintText: "Masukkan nama lengkap",
                                identifiedAs: "onlyText",
                                iconData: Icons.contact_mail,
                              ),
                              WidgetTextFormFieldAddUser(
                                controller: usernameC,
                                labelText: "Nama Pengguna",
                                hintText: "Masukkan nama pengguna",
                                identifiedAs: "username",
                                iconData: Icons.person,
                              ),
                              WidgetTextFormFieldAddUser(
                                controller: divisionC,
                                labelText: "Divisi",
                                hintText: "Masukkan divisi",
                                identifiedAs: "onlyText",
                                iconData: Icons.corporate_fare,
                              ),
                              WidgetTextFormFieldAddUser(
                                controller: phoneC,
                                labelText: "Nomor Telepon (opsional)",
                                hintText: "Masukkan nomor telepon",
                                identifiedAs: "phone",
                                iconData: Icons.phone_android,
                              ),
                              WidgetTextFormFieldAddUser(
                                controller: passwordC,
                                labelText: "Kata Sandi",
                                hintText: "Masukkan kata sandi",
                                identifiedAs: "password",
                                iconData: Icons.lock,
                              ),
                              WidgetTextFormFieldAddUser(
                                controller: confirmPasswordC,
                                labelText: "Konfirmasi Kata Sandi",
                                hintText: "Masukkan kata sandi kembali",
                                identifiedAs: "password",
                                iconData: Icons.lock,
                              ),
                              Gap(12.h),
                              loadingWidget(),
                              Gap(12.h),
                              WidgetActionProfileButton(
                                name: "Tambah",
                                onTap: addUserButton(),
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
