import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../core/utils/bloc_function.dart';
import '../../../../core/utils/sorting_filter_object.dart';
import '../../../../core/utils/utils.dart';
import '../../../attendance/presentation/manager/attendance_bloc.dart';
import '../widgets/widget_attendance_recap.dart';
import '../widgets/widget_shimmer_home.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void didChangeDependencies() {
    BlocFunction().getAttendance(context);
    BlocFunction().getProfile(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.maxFinite, 56.h),
        child: AppBar(
          title: const Text("Aplikasi Kehadiran"),
          titleTextStyle: StyleText().openSansHeaderBlack,
          backgroundColor: PaletteColor().softBlue1,
          actions: [
            InkWell(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    duration: Duration(seconds: 1),
                    content: Text("Notifikasi"),
                  ),
                );
              },
              splashColor: Colors.white.withOpacity(0.3),
              borderRadius: BorderRadius.circular(50),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.notifications,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {},
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: 12.h,
              horizontal: 12.w,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    "Laporan Kehadiran",
                    style: StyleText().openSansTitleBlack,
                  ),
                ),
                Gap(10.h),
                BlocBuilder<AttendanceBloc, AttendanceState>(
                  builder: (context, state) {
                    if (state is GetAttendanceSuccess) {
                      final attendance = state.attendances;

                      return Center(
                        child: Container(
                          height: 200,
                          width: 400,
                          decoration: BoxDecoration(
                            color: PaletteColor().white,
                            border: Border.all(color: PaletteColor().softBlue1),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Center(
                            child: Text(
                              "stream get attendance success ${attendance.length}",
                              style: StyleText().openSansBigValueBlack,
                            ),
                          ),
                        ),
                      );
                    }
                    return Center(
                      child: Container(
                        height: 200,
                        width: 400,
                        decoration: BoxDecoration(
                          color: PaletteColor().white,
                          border: Border.all(color: PaletteColor().softBlue1),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Center(
                          child: Text(
                            state.toString(),
                            style: StyleText().openSansBigValueBlack,
                          ),
                        ),
                      ),
                    );
                  },
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Kehadiranmu",
                      style: StyleText().openSansTitleBlack,
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.filter_alt),
                    )
                  ],
                ),
                Gap(10.h),
                BlocBuilder<AttendanceBloc, AttendanceState>(
                  builder: (context, state) {
                    print("HomeScreen");
                    print(state);
                    if (state is AttendanceLoading) {
                      return WidgetShimmerHome().attendanceRecapShimmer();
                    }
                    if (state is GetAttendanceSuccess) {
                      final attendance = state.attendances;
                      const activeWork = "2024-10-15 18:44:41.188637";
                      final absentAttend =
                          SortingFilterObject().absentAttendFilter(
                        stringStartDate: activeWork,
                        attendanceList: attendance,
                      );
                      final lateAttend = SortingFilterObject()
                          .attendanceLateFilter(
                              attendances: attendance, hour: 8, minute: 0);
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          WidgetAttendanceRecap(
                            name: "Hadir",
                            value: attendance.length.toString(),
                            identifiedAs: "present",
                          ),
                          WidgetAttendanceRecap(
                            name: "Terlambat",
                            value: lateAttend.length.toString(),
                            identifiedAs: "late",
                          ),
                          WidgetAttendanceRecap(
                            name: "Tidak Hadir",
                            value: absentAttend.length.toString(),
                            identifiedAs: "absent",
                          ),
                        ],
                      );
                    }
                    return WidgetShimmerHome().attendanceRecapShimmer();
                  },
                ),
                Gap(20.h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Pengajuan Izin",
                      style: StyleText().openSansTitleBlack,
                    ),
                    const Spacer(),
                    IconButton(onPressed: () {}, icon: const Icon(Icons.help))
                  ],
                ),
                Gap(10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 140.h,
                      width: 120.w,
                      decoration: BoxDecoration(
                          color: PaletteColor().white,
                          border: Border.all(color: PaletteColor().softBlue1),
                          borderRadius: BorderRadius.circular(8.r)),
                    ),
                    Container(
                      height: 140.h,
                      width: 120.w,
                      decoration: BoxDecoration(
                          color: PaletteColor().white,
                          border: Border.all(color: PaletteColor().softBlue1),
                          borderRadius: BorderRadius.circular(8.r)),
                    ),
                    Container(
                      height: 140.h,
                      width: 120.w,
                      decoration: BoxDecoration(
                          color: PaletteColor().white,
                          border: Border.all(color: PaletteColor().softBlue1),
                          borderRadius: BorderRadius.circular(8.r)),
                    ),
                  ],
                ),
                Gap(20.h),
                Text(
                  "Pengajuan Izin Terbaru",
                  style: StyleText().openSansTitleBlack,
                ),
                ListView.builder(
                  itemCount: 3,
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      child: Container(
                        height: 140.h,
                        width: 120.w,
                        decoration: BoxDecoration(
                          color: PaletteColor().white,
                          border: Border.all(color: PaletteColor().softBlue1),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
