import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginFormField extends StatefulWidget {
  const LoginFormField({
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
    required this.identifiedAs,
  });

  final TextEditingController controller;
  final String label, hint, identifiedAs;

  @override
  State<LoginFormField> createState() => _LoginFormFieldState();
}

class _LoginFormFieldState extends State<LoginFormField> {
  bool obscureTextValue = true;

  togglePasswordVisibility() {
    return () {
      setState(() {
        obscureTextValue = !obscureTextValue;
      });
    };
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: obscureText(),
      inputFormatters: textInputFormatter(),
      validator: validator(),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        label: Text(
          widget.label,
          style: GoogleFonts.openSans(),
        ),
        hintText: widget.hint,
        hintStyle: GoogleFonts.openSans(),
        suffixIcon: suffixIcon(),
      ),
    );
  }

  textInputFormatter() {
    if (widget.identifiedAs == "username") {
      return [
        FilteringTextInputFormatter.deny(
          RegExp(r'\s'),
        ),
        FilteringTextInputFormatter.allow(
          RegExp(r'[a-zA-Z0-9]'),
        )
      ];
    } else if (widget.identifiedAs == "password") {
      return [
        FilteringTextInputFormatter.allow(
          RegExp(r'[a-zA-Z0-9!@#$%^&*()_+\-=\[\]{\};:,<>./?\\|~ ]'),
        )
      ];
    } else {
      return [];
    }
  }

  validator() {
    if (widget.identifiedAs == "username") {
      return (value) {
        if (value == null || value.isEmpty) {
          return 'Nama pengguna tidak boleh kosong!';
        }
        if (value.length < 4) {
          return 'Masukkan nama pengguna yang valid';
        }
        return null;
      };
    } else if (widget.identifiedAs == "password") {
      return (value) {
        if (value == null || value.isEmpty) {
          return 'Kata sandi tidak boleh kosong!';
        }
        // Validasi minimal 1 huruf besar dan kombinasi huruf dan angka
        // if (!RegExp(
        //     r'^(?=.*[A-Z])(?=.*\d)[A-Za-z\d!@#$%^&*()_+\-=\[\]{\};:,<>./?\\|`~\s]+$')
        //     .hasMatch(value)) {
        //   return 'Password setidaknya mengandung huruf besar dan angka!';
        // }
        if (value.length < 6) {
          return 'Masukkan kata sandi yang valid';
        }
        return null;
      };
    } else {
      return [];
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
        onPressed: togglePasswordVisibility(),
        icon: Icon(
          obscureTextValue ? Icons.visibility : Icons.visibility_off,
        ),
      );
    }
  }
}
