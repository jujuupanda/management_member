import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/routes/route_app.dart';
import '../../../../core/utils/utils.dart';
import '../../../../core/widgets/custom_circle_loading.dart';
import '../../../../core/widgets/page_background.dart';
import '../manager/auth_bloc.dart';
import '../widgets/login_button.dart';
import '../widgets/login_form_field.dart';
import '../widgets/login_error_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController usernameC;
  late TextEditingController passwordC;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  //Login Button
  loginButton(BuildContext context) {
    return () {
      if (formKey.currentState!.validate()) {
        BlocFunction().loginButton(
          context,
          usernameC.text,
          passwordC.text,
        );
        // context.goNamed(RouteName().home);
      }
    };
  }

  @override
  void initState() {
    usernameC = TextEditingController();
    passwordC = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    usernameC.dispose();
    passwordC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          context.goNamed(RouteName().home);
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Stack(
          children: [
            const PageBackground(),
            LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints:
                        BoxConstraints(minHeight: constraints.maxHeight),
                    child: IntrinsicHeight(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            height: 250,
                            width: 250,
                            decoration: BoxDecoration(
                              color: PaletteColor().white,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.work,
                              color: PaletteColor().darkGrey,
                              size: 150,
                            ),
                          ),
                          Gap(30.h),
                          Container(
                            height: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: PaletteColor().white,
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(32.r),
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 12.w,
                                vertical: 30.h,
                              ),
                              child: Form(
                                key: formKey,
                                child: Column(
                                  children: [
                                    Gap(10.h),
                                    Text(
                                      "Masuk",
                                      style: StyleText().openSansBigValueBlack,
                                    ),
                                    Gap(30.h),
                                    LoginFormField(
                                      controller: usernameC,
                                      label: "Nama pengguna",
                                      hint: "Masukkan nama pengguna anda",
                                      identifiedAs: "username",
                                    ),
                                    const Gap(15),
                                    LoginFormField(
                                      controller: passwordC,
                                      label: "Kata sandi",
                                      hint: "Masukkan kata sandi anda",
                                      identifiedAs: "password",
                                    ),
                                    const Gap(10),
                                    loadingWidget(),
                                    const Gap(10),
                                    LoginButton(
                                      buttonName: "Masuk",
                                      onTap: loginButton(context),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  SizedBox loadingWidget() {
    return SizedBox(
      height: 40.h,
      child: Center(
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthLoading) {
              return const CustomCircleLoading();
            }
            if (state is LoginFailed) {
              return LoginErrorWidget(
                text: state.message,
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
