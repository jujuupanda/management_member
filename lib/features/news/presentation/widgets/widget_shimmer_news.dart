import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/utils.dart';
import '../../../../core/widgets/shimmer_widget.dart';

class WidgetShimmerNews {
  listNewsShimmer() {
    return ShimmerWidget(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: 10,
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 30.h,
        ),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 200.h,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: PaletteColor().white,
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(
                  width: 1,
                  color: PaletteColor().softGray,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
