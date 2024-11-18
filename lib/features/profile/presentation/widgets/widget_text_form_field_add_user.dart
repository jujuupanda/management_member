import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/utils.dart';

class WidgetTextFormFieldAddUser extends StatefulWidget {
  const WidgetTextFormFieldAddUser({
    super.key,
    required this.controller,
    required this.labelText,
    required this.hintText,
    required this.identifiedAs,
    required this.iconData,
  });

  final String labelText;
  final String hintText;
  final String identifiedAs;
  final IconData iconData;
  final TextEditingController controller;

  @override
  State<WidgetTextFormFieldAddUser> createState() =>
      _WidgetTextFormFieldAddUserState();
}

class _WidgetTextFormFieldAddUserState
    extends State<WidgetTextFormFieldAddUser> {
  bool obscureTextValue = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: TextFormField(
        controller: widget.controller,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        obscureText: obscureText(),
        keyboardType: keyboardType(),
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
    if (widget.identifiedAs == "username") {
      return [
        FilteringTextInputFormatter.deny(
          RegExp(r'\s'),
        ),
        FilteringTextInputFormatter.allow(
          RegExp(r'[a-zA-Z0-9]'),
        )
      ];
    }
    if (widget.identifiedAs == "password") {
      return [
        FilteringTextInputFormatter.allow(
          RegExp(r'[a-zA-Z0-9!@#$%^&*()_+\-=\[\]{\};:,<>./?\\|~ ]'),
        )
      ];
    }
    if (widget.identifiedAs == "phone") {
      return [
        FilteringTextInputFormatter.allow(
          RegExp(r'[0-9]'),
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

  keyboardType() {
    if (widget.identifiedAs == "phone") {
      return TextInputType.number;
    }
  }

  obscureText() {
    if (widget.identifiedAs == "password") {
      return obscureTextValue;
    }
    return false;
  }

  suffixIcon() {
    if (widget.identifiedAs == "password") {
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
    return null;
  }

  validator() {
    if (widget.identifiedAs == "username") {
      return (value) {
        if (value == null || value.isEmpty) {
          return 'Harus diisi, tidak boleh kosong!';
        }
        if (value.length < 4) {
          return 'Masukkan nama pengguna yang valid';
        }
        return null;
      };
    }
    if (widget.identifiedAs == "password") {
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
    if(widget.identifiedAs == "onlyText"){
      return (value){
        if (value == null || value.isEmpty) {
          return 'Harus diisi, tidak boleh kosong!';
        }
      };
    }
    return null;
  }
}
