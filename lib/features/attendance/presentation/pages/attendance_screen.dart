import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../core/utils/bloc_function.dart';
import '../../../../core/widgets/page_background.dart';
import '../../../../core/widgets/page_header_notification.dart';
import '../widgets/attendance_information_attend.dart';
import '../widgets/attendance_information_profile.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  @override
  void initState() {
    BlocFunction().getProfile(context);
    BlocFunction().attendChecker(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const PageBackground(),
          Column(
            children: [
              const PageHeaderNotification(),
              Gap(32.h),
              RefreshIndicator(
                onRefresh: () async {},
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      const AttendanceInformationProfile(),
                      Gap(12.h),
                      const AttendanceInformationAttend(),
                    ],
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
