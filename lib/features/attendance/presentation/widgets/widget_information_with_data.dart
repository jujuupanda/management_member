import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/utils/utils.dart';
import '../../domain/entities/attendance_entity.dart';
import 'widget_button_attendance.dart';
import 'widget_information_attend.dart';
import 'widget_information_timer.dart';

class WidgetInformationWithData extends StatelessWidget {
  const WidgetInformationWithData({
    super.key,
    required this.attendance,
    required this.onPhotoCaptured,
    this.isCaptured,
  });

  final AttendanceEntity attendance;
  final Function(File) onPhotoCaptured;
  final File? isCaptured;

  capturedPhoto() async {
    File capturedPhoto = await PickImage().pickImage(ImageSource.camera);
    onPhotoCaptured(capturedPhoto);
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
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Gap(12.h),
        const WidgetInformationTimer(),
        Gap(12.h),
        const WidgetInformationAttend(
          informationName: "Jam Kerja",
          informationValue: "08:00 s/d 17:00",
          title: true,
        ),
        WidgetInformationAttend(
          informationName: "Sistem Kerja",
          informationValue: (attendance.attendToday.checkIn == "")
              ? ""
              : attendance.attendToday.typeAttend,
        ),
        WidgetInformationAttend(
          informationName: "Lokasi",
          informationValue: (attendance.attendToday.checkIn == "")
              ? ""
              : attendance.attendToday.location,
        ),
        WidgetInformationAttend(
          informationName: "Waktu Masuk",
          informationValue: (attendance.attendToday.checkIn == "")
              ? ""
              : ParsingString().formatDateTimeHHmm(
                  attendance.attendToday.checkIn,
                ),
        ),
        WidgetInformationAttend(
          informationName: "Waktu Keluar",
          informationValue: (attendance.attendToday.checkIn == "")
              ? ""
              : ParsingString().formatDateTimeHHmm(
                  attendance.attendToday.checkOut,
                ),
        ),
        Gap(24.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            WidgetButtonAttendance(
              name: "Masuk",
              onTap: checkIn(context),
              isActive: attendance.attendToday.checkIn == "" &&
                      DateTime.now().hour < 17
                  ? true
                  : false,
            ),
            WidgetButtonAttendance(
              name: "Keluar",
              onTap: checkOut(context),
              isActive: attendance.attendToday.checkIn != "" &&
                      attendance.attendToday.checkOut == ""
                  ? true
                  : false,
            ),
          ],
        ),
      ],
    );
  }
}
