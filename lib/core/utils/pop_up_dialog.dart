import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../services/geo_location_service.dart';
import 'bloc_function.dart';
import 'utils.dart';

class PopUpDialog {
  void attendanceCheckInDialog(BuildContext context) {
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
                              ? PaletteColor().blue1
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
                              ? PaletteColor().blue1
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
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(
                    "Batal",
                    style: StyleText().openSansNormalBlack,
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    if (selectedOption == 0) {
                    } else {
                      if(selectedOption == 1){
                        attendType = "Luring/WFO";
                      } else {
                        attendType = "Daring/WFH";
                      }
                      final locationInfo =
                          await GeoLocationService().getCurrentLocation();
                      if (context.mounted) {
                        BlocFunction().checkInButton(
                          context,
                          attendType,
                          "imagePath",
                          "${locationInfo.latitude}, ${locationInfo.longitude}",
                        );
                      }
                      if (context.mounted) Navigator.of(context).pop();
                    }
                  },
                  child: Text(
                    "Pilih",
                    style: StyleText().openSansNormalBlack,
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
