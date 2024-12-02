import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../core/utils/utils.dart';
import '../../../../core/widgets/container_body.dart';
import '../../../../core/widgets/page_background.dart';
import '../../../../core/widgets/page_header.dart';
import '../manager/manage_attendance_bloc.dart';

class ManageAttendanceScreen extends StatefulWidget {
  const ManageAttendanceScreen({super.key});

  @override
  State<ManageAttendanceScreen> createState() => _ManageAttendanceScreenState();
}

class _ManageAttendanceScreenState extends State<ManageAttendanceScreen> {
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
                          if (listAttendance.isNotEmpty) {
                            return ListView.builder(
                              shrinkWrap: true,
                              padding: EdgeInsets.symmetric(
                                vertical: 16.h,
                                horizontal: 8.w,
                              ),
                              itemCount: groupedAttendanceByUsername.length,
                              itemBuilder: (context, index) {
                                final usernameGroup =
                                    groupedAttendanceByUsername.keys
                                        .toList()[index];
                                final listGrouped =
                                    groupedAttendanceByUsername[usernameGroup];

                                // final absentAttendance = SortingFilterObject().absentAttendanceFilter(stringActiveWork: stringActiveWork, stringSelectedMonth: stringSelectedMonth, listAttendance: listAttendance)
                                return Padding(
                                  padding: EdgeInsets.symmetric(vertical: 4.h),
                                  child: Container(
                                    decoration: const BoxDecoration(),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "username $usernameGroup",
                                          style:
                                              StyleText().openSansNormalBlack,
                                        ),
                                        ...listGrouped!.map(
                                          (e) => Text(
                                            e.attendToday.timeStamp,
                                            style:
                                                StyleText().openSansNormalBlack,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                            // return ListView.builder(
                            //   shrinkWrap: true,
                            //   padding: EdgeInsets.symmetric(vertical: 16.h),
                            //   itemCount: listAttendance.length,
                            //   itemBuilder: (context, index) {
                            //     return Padding(
                            //       padding: EdgeInsets.symmetric(vertical: 4.h),
                            //       child: Container(
                            //         decoration: const BoxDecoration(),
                            //         child: Column(
                            //           children: [
                            //             Text(
                            //               "user: ${listAttendance[index].username}",
                            //               style:
                            //                   StyleText().openSansNormalBlack,
                            //             ),
                            //             Text(
                            //               "user: ${listAttendance[index].attendToday.timeStamp}",
                            //               style:
                            //               StyleText().openSansNormalBlack,
                            //             ),
                            //           ],
                            //         ),
                            //       ),
                            //     );
                            //   },
                            // );
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

  /// attendance grouped (absent, late, presence)
// Row attendanceReportByDate(
//     BuildContext context,
//     List<AttendanceEntity> attendancePresent,
//     List<AttendanceEntity> attendanceLate,
//     List<DateTime> attendanceAbsent) {
//   return Row(
//     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     children: [
//       GestureDetector(
//         onTap: () {
//           context.pushNamed(
//             RouteName().present,
//             extra: attendancePresent,
//           );
//         },
//         child: WidgetAttendanceRecap(
//           name: "Hadir",
//           value: attendancePresent.length.toString(),
//           identifiedAs: "present",
//         ),
//       ),
//       GestureDetector(
//         onTap: () {
//           context.pushNamed(
//             RouteName().late,
//             extra: attendanceLate,
//           );
//         },
//         child: WidgetAttendanceRecap(
//           name: "Terlambat",
//           value: attendanceLate.length.toString(),
//           identifiedAs: "late",
//         ),
//       ),
//       GestureDetector(
//         onTap: () {
//           context.pushNamed(
//             RouteName().absent,
//             extra: attendanceAbsent,
//           );
//         },
//         child: WidgetAttendanceRecap(
//           name: "Tidak Hadir",
//           value: attendanceAbsent.length.toString(),
//           identifiedAs: "absent",
//         ),
//       ),
//     ],
//   );
// }
}
