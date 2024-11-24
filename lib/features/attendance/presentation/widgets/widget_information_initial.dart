import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/utils/utils.dart';
import 'widget_information_attend.dart';
import 'widget_information_timer.dart';

import 'widget_button_attendance.dart';

class WidgetInformationInitial extends StatelessWidget {
  const WidgetInformationInitial({
    super.key,
    required this.onPhotoCaptured,
    this.isCaptured,
  });

  final Function(File) onPhotoCaptured;
  final File? isCaptured;

  capturedPhoto() async {
    final capturedPhoto = await PickImage().pickImage(ImageSource.camera);
    if (capturedPhoto != null) {
      onPhotoCaptured(capturedPhoto);
    }
  }

  checkIn(BuildContext context) {
    return isCaptured != null
        ? () {
            PopUpDialog().attendanceCheckInDialog(context, isCaptured!);
          }
        : () {
            capturedPhoto();
          };
  }

  checkOut(BuildContext context) {
    return () {
      BlocFunction().checkOutButton(context);
    };
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Gap(12.h),
        const WidgetInformationTimer(),
        Gap(12.h),
        const WidgetInformationAttend(
          informationName: "Jam Kerja",
          informationValue: "08:00 s/d 17:00",
          title: true,
        ),
        const WidgetInformationAttend(
          informationName: "Sistem Kerja",
          informationValue: "",
        ),
        const WidgetInformationAttend(
          informationName: "Lokasi",
          informationValue: "",
        ),
        const WidgetInformationAttend(
          informationName: "Waktu Masuk",
          informationValue: "",
        ),
        const WidgetInformationAttend(
          informationName: "Waktu Keluar",
          informationValue: "",
        ),
        Gap(24.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            WidgetButtonAttendance(
              name: "Masuk",
              onTap: checkIn(context),
              isActive: DateTime.now().hour < 17 ? true : false,
            ),
            WidgetButtonAttendance(
              name: "Keluar",
              onTap: checkOut(context),
              isActive: false,
            ),
          ],
        ),
      ],
    );
  }
}
