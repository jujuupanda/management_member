import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/container_body.dart';
import '../../../../core/widgets/page_background.dart';
import '../../../../core/widgets/page_header.dart';
import '../../../attendance/domain/entities/attendance_entity.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

import '../../../../core/routes/route_app.dart';
import '../../../../core/utils/utils.dart';
import '../../../attendance/presentation/manager/attendance_bloc.dart';
import '../widgets/attendance_chart_legend.dart';
import '../widgets/pie_chart_attendance.dart';
import '../widgets/widget_attendance_recap.dart';
import '../widgets/widget_shimmer_home.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime? selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    BlocFunction().getAttendance(context);
  }

  Future<void> monthPicker(BuildContext contexto) async {
    return await showMonthPicker(
      context: contexto,
      firstDate: DateTime(DateTime.now().year - 2, 5),
      lastDate: DateTime(DateTime.now().year + 2, 9),
      initialDate: selectedDate ?? DateTime.now(),
      confirmWidget: Text(
        'Pilih',
        style: StyleText().openSansTitleBlack,
      ),
      cancelWidget: Text(
        'Batal',
        style: StyleText().openSansTitleBlack,
      ),
      monthPickerDialogSettings: MonthPickerDialogSettings(
        headerSettings: PickerHeaderSettings(
          headerBackgroundColor: Colors.blueAccent,
          headerCurrentPageTextStyle: StyleText().openSansTitleWhite,
          headerSelectedIntervalTextStyle: StyleText().openSansTitleWhite,
        ),
      ),
    ).then((DateTime? date) {
      if (date != null) {
        setState(() {
          selectedDate = date;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const PageBackground(),
          Column(
            children: [
              const PageHeader(
                isHome: true,
              ),
              Gap(10.h),
              Expanded(
                child: ContainerBody(
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 12.h,
                        horizontal: 12.w,
                      ),
                      child: BlocBuilder<AttendanceBloc, AttendanceState>(
                        builder: (context, state) {
                          if (state is AttendancesLoaded) {
                            if (state.isLoading == true) {
                              return WidgetShimmerHome()
                                  .homeScreenShimmer(context);
                            }
                            final attendances = state.attendances!;
                            final attendanceSorted = selectedDate != null
                                ? attendances
                                    .where((date) =>
                                        DateTime.parse(
                                                    date.attendToday.timeStamp)
                                                .year ==
                                            selectedDate!.year &&
                                        DateTime.parse(
                                                    date.attendToday.timeStamp)
                                                .month ==
                                            selectedDate!.month)
                                    .toList()
                                : attendances;

                            final attendancePresent = SortingFilterObject()
                                .attendanceSortingFilter(
                                    attendances: attendanceSorted);
                            final attendanceLate =
                                SortingFilterObject().attendanceLateFilter(
                              attendances: attendanceSorted,
                              hour: 8,
                              minute: 0,
                            );
                            final attendanceAbsent =
                                SortingFilterObject().absentAttendFilter(
                              startDate: selectedDate,
                              activeWork: state.activeWork!,
                              attendanceList: attendanceSorted,
                            );
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                titleAttendanceReport(context),
                                Gap(10.h),
                                attendanceChart(
                                  attendancePresent,
                                  attendanceLate,
                                  attendanceAbsent,
                                ),
                                Gap(10.h),
                                titleYourAttendance(context),
                                Gap(10.h),
                                attendanceReportByDate(
                                  context,
                                  attendancePresent,
                                  attendanceLate,
                                  attendanceAbsent,
                                ),
                                Gap(120.h),
                                // titleExcusedProposal(context),
                                // Gap(10.h),
                                // excusedProposalList(),
                                // Gap(20.h),
                                // titleLatestExcusedProposal(),
                                // latestExcusedProposal(),
                                // Gap(20.h),
                              ],
                            );
                          }
                          return WidgetShimmerHome().homeScreenShimmer(context);
                        },
                      ),
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

  AppBar appBarHome(BuildContext context) {
    return AppBar(
      title: const Text("Aplikasi Kehadiran"),
      titleTextStyle: StyleText().openSansHeaderBlack,
      backgroundColor: PaletteColor().softBlack,
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
    );
  }

  ListView latestExcusedProposal() {
    return ListView.builder(
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
              border: Border.all(color: PaletteColor().lightGray),
              borderRadius: BorderRadius.circular(8.r),
            ),
          ),
        );
      },
    );
  }

  Text titleLatestExcusedProposal() {
    return Text(
      "Pengajuan Izin Terbaru",
      style: StyleText().openSansTitleBlack,
    );
  }

  Row excusedProposalList() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: 140.h,
          width: 120.w,
          decoration: BoxDecoration(
              color: PaletteColor().white,
              border: Border.all(color: PaletteColor().lightGray),
              borderRadius: BorderRadius.circular(8.r)),
        ),
        Container(
          height: 140.h,
          width: 120.w,
          decoration: BoxDecoration(
              color: PaletteColor().white,
              border: Border.all(color: PaletteColor().lightGray),
              borderRadius: BorderRadius.circular(8.r)),
        ),
        Container(
          height: 140.h,
          width: 120.w,
          decoration: BoxDecoration(
              color: PaletteColor().white,
              border: Border.all(color: PaletteColor().lightGray),
              borderRadius: BorderRadius.circular(8.r)),
        ),
      ],
    );
  }

  Container titleExcusedProposal(BuildContext context) {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: PaletteColor().transparent,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Pengajuan Izin",
            style: StyleText().openSansTitleBlack,
          ),
          const Spacer(),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.help),
          )
        ],
      ),
    );
  }

  Row attendanceReportByDate(
      BuildContext context,
      List<AttendanceEntity> attendancePresent,
      List<AttendanceEntity> attendanceLate,
      List<DateTime> attendanceAbsent) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            context.pushNamed(
              RouteName().present,
              extra: attendancePresent,
            );
          },
          child: WidgetAttendanceRecap(
            name: "Hadir",
            value: attendancePresent.length.toString(),
            identifiedAs: "present",
          ),
        ),
        GestureDetector(
          onTap: () {
            context.pushNamed(
              RouteName().late,
              extra: attendanceLate,
            );
          },
          child: WidgetAttendanceRecap(
            name: "Terlambat",
            value: attendanceLate.length.toString(),
            identifiedAs: "late",
          ),
        ),
        GestureDetector(
          onTap: () {
            context.pushNamed(
              RouteName().absent,
              extra: attendanceAbsent,
            );
          },
          child: WidgetAttendanceRecap(
            name: "Tidak Hadir",
            value: attendanceAbsent.length.toString(),
            identifiedAs: "absent",
          ),
        ),
      ],
    );
  }

  Container titleYourAttendance(BuildContext context) {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: PaletteColor().transparent,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Kehadiranmu",
            style: StyleText().openSansTitleBlack,
          ),
          const Spacer(),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.help),
          ),
        ],
      ),
    );
  }

  Center attendanceChart(List<AttendanceEntity> attendancePresent,
      List<AttendanceEntity> attendanceLate, List<DateTime> attendanceAbsent) {
    return Center(
      child: Container(
        height: 300,
        width: 400,
        decoration: BoxDecoration(
          color: PaletteColor().white,
          border: Border.all(color: PaletteColor().lightGray),
          borderRadius: BorderRadius.circular(8.r),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 2,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Stack(
          children: [
            PieChartAttendance(
              attendancePresent: attendancePresent,
              attendanceLate: attendanceLate,
              attendanceAbsent: attendanceAbsent,
            ),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 8.h,
                  horizontal: 8.w,
                ),
                child: Text(
                  selectedDate != null
                      ? ParsingString().formatDateTimeIDOnlyMonthYear(
                          selectedDate.toString())
                      : "Semua Tanggal",
                  style: StyleText().openSansTitleBlack,
                ),
              ),
            ),
            const AttendChartLegend(),
          ],
        ),
      ),
    );
  }

  Container titleAttendanceReport(BuildContext context) {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: PaletteColor().transparent,
      ),
      child: Stack(
        children: [
          Center(
            child: Text(
              "Laporan Kehadiran",
              style: StyleText().openSansTitleBlack,
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              selectedDate != null
                  ? IconButton(
                      onPressed: () {
                        setState(() {
                          selectedDate = null;
                        });
                      },
                      icon: const Icon(Icons.close),
                    )
                  : const SizedBox(),
              IconButton(
                onPressed: () {
                  monthPicker(context);
                },
                icon: const Icon(Icons.filter_alt),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
