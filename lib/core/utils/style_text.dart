import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'color_palette.dart';

class StyleText {
  TextStyle openSansNormalBlack = GoogleFonts.openSans();
  TextStyle openSansNormalRed = GoogleFonts.openSans(
    color: ColorPalette().redWarning,
  );
  TextStyle openSansNormalWhite = GoogleFonts.openSans(
    color: ColorPalette().white,
  );
  TextStyle openSansTitle = GoogleFonts.openSans(
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
  );
  TextStyle openSansTitleWhite = GoogleFonts.openSans(
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
    color: ColorPalette().white,
  );
  TextStyle openSansBigValueWhite = GoogleFonts.openSans(
    fontSize: 18.sp,
    fontWeight: FontWeight.w700,
    color: ColorPalette().white,
  );
  TextStyle openSansBigValueBlack = GoogleFonts.openSans(
    fontSize: 18.sp,
    fontWeight: FontWeight.w700,
    color: ColorPalette().black,
  );
  TextStyle openSansHeader = GoogleFonts.openSans(
    fontSize: 18.sp,
    fontWeight: FontWeight.w700,
  );
}
