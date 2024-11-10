import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/routes/route_app.dart';
import '../../../../core/services/token_service.dart';
import '../../../../core/widgets/custom_circle_loading.dart';
import '../../domain/use_cases/login_use_case.dart';
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
  loginButton() {
    return () {
      if (formKey.currentState!.validate()) {
        BlocProvider.of<AuthBloc>(context).add(
          LoginEvent(
            LoginParam(
              usernameC.text,
              passwordC.text,
            ),
          ),
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
        body: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                const Gap(20),
                BlocBuilder<AuthBloc, AuthState>(
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
                const Gap(20),
                LoginButton(
                  buttonName: "Masuk",
                  onTap: loginButton(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
