import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/utils.dart';

class WidgetTextFormFieldEditPassword extends StatefulWidget {
  const WidgetTextFormFieldEditPassword({
    super.key,
    required this.controller,
    required this.labelText,
    required this.hintText,
    required this.identifiedAs,
    required this.iconData,
    this.anotherController,
  });

  final String labelText;
  final String hintText;
  final String identifiedAs;
  final IconData iconData;
  final TextEditingController controller;
  final TextEditingController? anotherController;

  @override
  State<WidgetTextFormFieldEditPassword> createState() =>
      _WidgetTextFormFieldEditPasswordState();
}

class _WidgetTextFormFieldEditPasswordState
    extends State<WidgetTextFormFieldEditPassword> {
  bool obscureTextValue = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: TextFormField(
        controller: widget.controller,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        obscureText: obscureText(),
        inputFormatters: inputFormatter(),
        validator: validator(),
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: widget.labelText,
          labelStyle: StyleText().openSansNormalBlack,
          hintText: widget.hintText,
          hintStyle: StyleText().openSansNormalBlack,
          prefixIcon: Icon(widget.iconData),
          suffixIcon: suffixIcon(),
        ),
      ),
    );
  }

  List<TextInputFormatter> inputFormatter() {
    if (widget.identifiedAs == "newPassword" ||
        widget.identifiedAs == "confirmNewPassword") {
      return [
        FilteringTextInputFormatter.allow(
          RegExp(r'[a-zA-Z0-9!@#$%^&*()_+\-=\[\]{\};:,<>./?\\|~ ]'),
        )
      ];
    }
    return [
      FilteringTextInputFormatter.deny(
        RegExp(
          r'[\u{1F600}-\u{1F64F}'
          r'\u{1F300}-\u{1F5FF}'
          r'\u{1F680}-\u{1F6FF}'
          r'\u{1F1E0}-\u{1F1FF}'
          r'\u{2600}-\u{26FF}'
          r'\u{2700}-\u{27BF}'
          r'\u{FE00}-\u{FE0F}'
          r'\u{1F900}-\u{1F9FF}'
          r'\u{1F018}-\u{1F270}'
          r'\u{238C}-\u{2454}'
          r']',
          unicode: true,
        ),
      )
    ];
  }

  validator() {
    if (widget.identifiedAs == "newPassword") {
      return (value) {
        if (value == null || value.isEmpty) {
          return 'Harus diisi, tidak boleh kosong!';
        }
        // Validasi minimal 1 huruf besar dan kombinasi huruf dan angka
        if (!RegExp(
                r'^(?=.*[A-Z])(?=.*\d)[A-Za-z\d!@#$%^&*()_+\-=\[\]{\};:,<>./?\\|`~\s]+$')
            .hasMatch(value)) {
          return 'Password setidaknya mengandung huruf besar dan angka!';
        }
        if (value.length < 6) {
          return 'Masukkan kata sandi yang valid';
        }
        return null;
      };
    }
    if (widget.identifiedAs == "confirmNewPassword") {
      return (value) {
        if (value == null || value.isEmpty) {
          return 'Harus diisi, tidak boleh kosong!';
        }
        // Validasi minimal 1 huruf besar dan kombinasi huruf dan angka
        if (!RegExp(
                r'^(?=.*[A-Z])(?=.*\d)[A-Za-z\d!@#$%^&*()_+\-=\[\]{\};:,<>./?\\|`~\s]+$')
            .hasMatch(value)) {
          return 'Password setidaknya mengandung huruf besar dan angka!';
        }
        if (value.length < 6) {
          return 'Masukkan kata sandi yang valid';
        }
        if (value != widget.anotherController!.text) {
          return 'Kata sandi baru tidak cocok';
        }
        return null;
      };
    }
    return null;
  }

  obscureText() {
    return obscureTextValue;
  }

  suffixIcon() {
    return IconButton(
      onPressed: () {
        setState(() {
          obscureTextValue = !obscureTextValue;
        });
      },
      icon: Icon(
        obscureTextValue ? Icons.visibility : Icons.visibility_off,
      ),
    );
  }
}
