import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

import '../../../../core/utils/utils.dart';
import '../../../../core/widgets/container_body.dart';
import '../../../../core/widgets/page_background.dart';
import '../../../../core/widgets/page_header.dart';
import '../../../attendance/domain/entities/attendance_entity.dart';
import '../manager/manage_attendance_bloc.dart';
import '../widgets/widget_attendance_recap.dart';

class ManageAttendanceScreen extends StatefulWidget {
  const ManageAttendanceScreen({super.key});

  @override
  State<ManageAttendanceScreen> createState() => _ManageAttendanceScreenState();
}

class _ManageAttendanceScreenState extends State<ManageAttendanceScreen> {
  DateTime? selectedDate = DateTime.now();

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
                isDetail: true,
                page: "home",
              ),
              Gap(10.h),
              Expanded(
                child: ContainerBody(
                  child: RefreshIndicator(
                    onRefresh: () async {},
                    child: BlocBuilder<ManageAttendanceBloc,
                        ManageAttendanceState>(
                      builder: (context, state) {
                        if (state is ManageAttendanceLoaded) {
                          final listAttendance = state.listAttendanceAllUser!;
                          final groupedAttendanceByUsername = groupBy(
                            listAttendance,
                            (p0) => p0.username,
                          );
                          final listUser = state.listAllUser!;
                          if (listAttendance.isNotEmpty) {
                            return Column(
                              children: [
                                Gap(10.h),
                                titleAttendanceReport(context),
                                ListView.builder(
                                  shrinkWrap: true,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 8.w,
                                  ),
                                  itemCount: groupedAttendanceByUsername.length,
                                  itemBuilder: (context, index) {
                                    final usernameGroup =
                                        groupedAttendanceByUsername.keys
                                            .toList()[index];
                                    final listGrouped =
                                        groupedAttendanceByUsername[
                                            usernameGroup]!;
                                    final user = listUser.firstWhere(
                                        (element) =>
                                            element.username == usernameGroup);

                                    // Pemisah
                                    final attendanceSorted =
                                        selectedDate != null
                                            ? listGrouped
                                                .where((date) =>
                                                    DateTime.parse(date
                                                                .attendToday
                                                                .timeStamp)
                                                            .year ==
                                                        selectedDate!.year &&
                                                    DateTime.parse(date
                                                                .attendToday
                                                                .timeStamp)
                                                            .month ==
                                                        selectedDate!.month)
                                                .toList()
                                            : listGrouped;
                                    //hadir
                                    final attendancePresent =
                                        SortingFilterObject()
                                            .attendanceSortingFilter(
                                                attendances: attendanceSorted);
                                    //telat
                                    final attendanceLate = SortingFilterObject()
                                        .lateAttendanceFilter(
                                      attendances: attendanceSorted,
                                      hour: 8,
                                      minute: 0,
                                    );
                                    //tidak hadir
                                    final attendanceAbsent =
                                        SortingFilterObject()
                                            .absentAttendanceFilter(
                                      selectedMonth: selectedDate,
                                      stringActiveWork: user.activeWork,
                                      listAttendance: attendanceSorted,
                                    );
                                    return Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 12.h),
                                      child: Container(
                                        decoration: const BoxDecoration(),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              user.fullName,
                                              style: StyleText()
                                                  .openSansBigValueBlack,
                                            ),
                                            Gap(10.h),
                                            attendanceReportByDate(
                                              context,
                                              attendancePresent,
                                              attendanceLate,
                                              attendanceAbsent,
                                            ),
                                            // ...listGrouped!.map(
                                            //   (e) => Text(
                                            //     e.attendToday.timeStamp,
                                            //     style:
                                            //         StyleText().openSansNormalBlack,
                                            //   ),
                                            // ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            );
                          }
                          return Text(
                            "Kosong",
                            style: StyleText().openSansTitleBlack,
                          );
                        }
                        return const SizedBox();
                      },
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

  Container titleAttendanceReport(BuildContext context) {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: PaletteColor().transparent,
      ),
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              BlocFunction().getAllAttendanceAllAccount(context);
            },
            child: Center(
              child: Text(
                "Laporan Kehadiran",
                style: StyleText().openSansTitleBlack,
              ),
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
            // context.pushNamed(
            //   RouteName().present,
            //   extra: attendancePresent,
            // );
          },
          child: WidgetAttendanceRecap(
            name: "Hadir",
            value: attendancePresent.length.toString(),
            identifiedAs: "present",
          ),
        ),
        GestureDetector(
          onTap: () {
            // context.pushNamed(
            //   RouteName().late,
            //   extra: attendanceLate,
            // );
          },
          child: WidgetAttendanceRecap(
            name: "Terlambat",
            value: attendanceLate.length.toString(),
            identifiedAs: "late",
          ),
        ),
        GestureDetector(
          onTap: () {
            // context.pushNamed(
            //   RouteName().absent,
            //   extra: attendanceAbsent,
            // );
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
}
