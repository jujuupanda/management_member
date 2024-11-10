import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginErrorWidget extends StatelessWidget {
  const LoginErrorWidget({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        text,
        style: GoogleFonts.openSans(
          color: Colors.redAccent,
          fontSize: 14,
        ),
      ),
    );
  }
}
