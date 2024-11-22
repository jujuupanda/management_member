part of 'utils.dart';

class StyleText {
  TextStyle openSansSmallBlack = GoogleFonts.openSans(fontSize: 10.sp);
  TextStyle openSansSmallWhite = GoogleFonts.openSans(
    fontSize: 10.sp,
    color: PaletteColor().white,
  );
  TextStyle openSansNormalBlack = GoogleFonts.openSans();
  TextStyle openSansNormalRed = GoogleFonts.openSans(
    color: PaletteColor().redWarning,
  );
  TextStyle openSansNormalWhite = GoogleFonts.openSans(
    color: PaletteColor().white,
  );
  TextStyle openSansTitleSoftBlue1 = GoogleFonts.openSans(
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
    color: PaletteColor().softBlue1,
  );
  TextStyle openSansTitleBlack = GoogleFonts.openSans(
    fontSize: 18.sp,
    fontWeight: FontWeight.w600,
  );
  TextStyle openSansTitleWhite = GoogleFonts.openSans(
    fontSize: 18.sp,
    fontWeight: FontWeight.w600,
    color: PaletteColor().white,
  );
  TextStyle openSansBigValueWhite = GoogleFonts.openSans(
    fontSize: 18.sp,
    fontWeight: FontWeight.w700,
    color: PaletteColor().white,
  );
  TextStyle openSansBigValueBlack = GoogleFonts.openSans(
    fontSize: 18.sp,
    fontWeight: FontWeight.w700,
    color: PaletteColor().black,
  );
  TextStyle openSansHeaderBlack = GoogleFonts.openSans(
    fontSize: 18.sp,
    fontWeight: FontWeight.w700,
  );
}
