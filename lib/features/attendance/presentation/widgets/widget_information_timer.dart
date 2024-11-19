import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/parsing_string.dart';
import '../../../../core/utils/utils.dart';

class WidgetInformationTimer extends StatefulWidget {
  const WidgetInformationTimer({
    super.key,
  });

  @override
  State<WidgetInformationTimer> createState() => _WidgetInformationTimerState();
}

class _WidgetInformationTimerState extends State<WidgetInformationTimer> {
  late Timer timer;
  DateTime currentTime = DateTime.now();

  @override
  void initState() {
    super.initState();
    realTimeClock();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  realTimeClock() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        currentTime = DateTime.now();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 45.h,
        width: 110.w,
        decoration: BoxDecoration(
          border: Border.all(color: PaletteColor().blue1),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Center(
          child: Text(
            ParsingString().formatDateTimeHHmm(currentTime.toString()),
            style: StyleText().openSansBigValueBlack,
          ),
        ),
      ),
    );
  }
}
