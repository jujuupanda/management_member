part of 'utils.dart';

class PopUpDialog {
  void attendanceCheckInDialog(BuildContext context, File file) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        int selectedOption = 0;
        String attendType = "";
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text(
                "Sistem Kerja",
                style: StyleText().openSansBigValueBlack,
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Option 1
                  InkWell(
                    onTap: () => setState(() => selectedOption = 1),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 8.h,
                        horizontal: 8.w,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: selectedOption == 1
                              ? PaletteColor().softBlack
                              : PaletteColor().gray,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Checkbox(
                            value: selectedOption == 1,
                            onChanged: (bool? value) {
                              setState(() {
                                selectedOption = value! ? 1 : 0;
                              });
                            },
                          ),
                          Text(
                            "Luring/WFO",
                            style: StyleText().openSansTitleBlack,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Gap(10.h),
                  // Option 2
                  InkWell(
                    onTap: () => setState(() => selectedOption = 2),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 8.h,
                        horizontal: 8.w,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: selectedOption == 2
                              ? PaletteColor().softBlack
                              : PaletteColor().gray,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Checkbox(
                            value: selectedOption == 2,
                            onChanged: (bool? value) {
                              setState(() {
                                selectedOption = value! ? 2 : 0;
                              });
                            },
                          ),
                          Text(
                            "Daring/WFH",
                            style: StyleText().openSansTitleBlack,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 35.h,
                      width: 80.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        border: Border.all(
                            color: PaletteColor().softDarkGrey, width: 1),
                        color: PaletteColor().white,
                      ),
                      child: Material(
                        color: PaletteColor().transparent,
                        child: InkWell(
                          onTap: () => context.pop(),
                          splashColor: PaletteColor().lightGray,
                          borderRadius: BorderRadius.circular(10.r),
                          child: Center(
                            child: Text(
                              "Batal",
                              style: StyleText().openSansNormalBlack,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 35.h,
                      width: 80.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        color: PaletteColor().softDarkGrey,
                      ),
                      child: Material(
                        color: PaletteColor().transparent,
                        child: InkWell(
                          onTap: () async {
                            if (selectedOption == 0) {
                            } else {
                              if (selectedOption == 1) {
                                attendType = "Luring/WFO";
                              } else {
                                attendType = "Daring/WFH";
                              }
                              final locationInfo = await GeoLocationService()
                                  .getCurrentLocation();
                              final photoUrl = await PickImage()
                                  .uploadImage(file, "attendance");
                              if (context.mounted) {
                                BlocFunction().checkInButton(
                                  context,
                                  attendType,
                                  photoUrl,
                                  "${locationInfo.latitude}, ${locationInfo.longitude}",
                                );
                                Navigator.of(context).pop();
                              }
                            }
                          },
                          splashColor: PaletteColor().lightGray,
                          borderRadius: BorderRadius.circular(10.r),
                          child: Center(
                            child: Text(
                              "Pilih",
                              style: StyleText().openSansNormalWhite,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        );
      },
    );
  }

  void successUpdateProfile(BuildContext context, String text) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.symmetric(
            horizontal: 10.w,
            vertical: 10.h,
          ),
          title: Text(
            "Berhasil",
            style: StyleText().openSansBigValueBlack,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Gap(20.h),
              Icon(
                Icons.check_circle_outline_rounded,
                size: 90,
                color: PaletteColor().softDarkGrey,
              ),
              Gap(10.h),
              Text(
                text,
                style: StyleText().openSansNormalBlack,
              ),
              Gap(20.h),
            ],
          ),
          actions: [
            Container(
              height: 35.h,
              width: 80.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color: PaletteColor().softDarkGrey,
              ),
              child: Material(
                color: PaletteColor().transparent,
                child: InkWell(
                  onTap: () => context.goNamed(RouteName().profile),
                  splashColor: PaletteColor().lightGray,
                  borderRadius: BorderRadius.circular(10.r),
                  child: Center(
                    child: Text(
                      "Baik",
                      style: StyleText().openSansNormalWhite,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  exitPopUp(BuildContext context, VoidCallback onTap) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.symmetric(
            horizontal: 10.w,
            vertical: 10.h,
          ),
          title: Text(
            "Keluar",
            style: StyleText().openSansBigValueBlack,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Gap(20.h),
              Icon(
                Icons.logout,
                size: 90,
                color: PaletteColor().softDarkGrey,
              ),
              Gap(10.h),
              Text(
                "Ingin keluar aplikasi?",
                style: StyleText().openSansNormalBlack,
              ),
              Gap(20.h),
            ],
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 35.h,
                  width: 80.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(
                        color: PaletteColor().softDarkGrey, width: 1),
                    color: PaletteColor().white,
                  ),
                  child: Material(
                    color: PaletteColor().transparent,
                    child: InkWell(
                      onTap: () => context.pop(),
                      splashColor: PaletteColor().lightGray,
                      borderRadius: BorderRadius.circular(10.r),
                      child: Center(
                        child: Text(
                          "Batal",
                          style: StyleText().openSansNormalBlack,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 35.h,
                  width: 80.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: PaletteColor().softDarkGrey,
                  ),
                  child: Material(
                    color: PaletteColor().transparent,
                    child: InkWell(
                      onTap: () {
                        onTap();
                        context.pop();
                      },
                      splashColor: PaletteColor().lightGray,
                      borderRadius: BorderRadius.circular(10.r),
                      child: Center(
                        child: Text(
                          "Keluar",
                          style: StyleText().openSansNormalWhite,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  caution(BuildContext context, IconData iconData, String message,
      VoidCallback onTap) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.symmetric(
            horizontal: 10.w,
            vertical: 10.h,
          ),
          title: Text(
            "Perhatian",
            style: StyleText().openSansBigValueBlack,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Gap(20.h),
              Icon(
                iconData,
                size: 90,
                color: PaletteColor().softDarkGrey,
              ),
              Gap(10.h),
              Text(
                message,
                style: StyleText().openSansNormalBlack,
              ),
              Gap(20.h),
            ],
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 35.h,
                  width: 80.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(
                        color: PaletteColor().softDarkGrey, width: 1),
                    color: PaletteColor().white,
                  ),
                  child: Material(
                    color: PaletteColor().transparent,
                    child: InkWell(
                      onTap: () => context.pop(),
                      splashColor: PaletteColor().lightGray,
                      borderRadius: BorderRadius.circular(10.r),
                      child: Center(
                        child: Text(
                          "Tidak",
                          style: StyleText().openSansNormalBlack,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 35.h,
                  width: 80.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: PaletteColor().softDarkGrey,
                  ),
                  child: Material(
                    color: PaletteColor().transparent,
                    child: InkWell(
                      onTap: () {
                        onTap();
                        context.pop();
                      },
                      splashColor: PaletteColor().lightGray,
                      borderRadius: BorderRadius.circular(10.r),
                      child: Center(
                        child: Text(
                          "Ya",
                          style: StyleText().openSansNormalWhite,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
