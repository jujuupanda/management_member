import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../core/utils/utils.dart';
import '../../../../core/widgets/page_background.dart';
import '../../../../core/widgets/page_header.dart';
import '../widgets/attendance_information_attend.dart';
import '../widgets/attendance_information_photo.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  File? capturedPhoto;

  @override
  void initState() {
    super.initState();
    BlocFunction().getProfile(context);
    BlocFunction().attendChecker(context);
  }

  void updatePhoto(File photo) {
    setState(() {
      capturedPhoto = photo;
    });
  }

  bool get isCaptured => capturedPhoto != null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const PageBackground(),
          Column(
            children: [
              const PageHeader(),
              Gap(32.h),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    BlocFunction().attendChecker(context);
                  },
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        AttendanceInformationPhoto(
                          photo: capturedPhoto,
                        ),
                        Gap(12.h),
                        AttendanceInformationAttend(
                          onPhotoCaptured: updatePhoto,
                          isCaptured: isCaptured,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
