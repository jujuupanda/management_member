import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/utils.dart';

class WidgetInformationAttend extends StatelessWidget {
  const WidgetInformationAttend({
    super.key,
    required this.informationName,
    required this.informationValue,
    this.title = false,
  });

  final String informationName;
  final String informationValue;
  final bool? title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 28.h,
            width: 100.w,
            color: PaletteColor().transparent,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                informationName,
                style: title == true
                    ? StyleText().openSansTitleBlack
                    : StyleText().openSansNormalBlack,
                maxLines: 1,
                overflow: TextOverflow.fade,
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: 28.h,
              color: PaletteColor().transparent,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  ": $informationValue",
                  style: title == true
                      ? StyleText().openSansTitleBlack
                      : StyleText().openSansNormalBlack,
                  maxLines: 1,
                  overflow: TextOverflow.fade,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
