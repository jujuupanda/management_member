import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../core/utils/utils.dart';
import '../../../../core/widgets/page_background.dart';
import '../../../../core/widgets/page_header.dart';
import '../../../attendance/domain/entities/attendance_entity.dart';
import '../widgets/expansion_tile_presence.dart';

class PresentScreen extends StatelessWidget {
  const PresentScreen({super.key, required this.attendance});

  final List<AttendanceEntity> attendance;

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
              ),
              Gap(18.h),
              Expanded(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: PaletteColor().white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(32.r),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.4),
                        spreadRadius: 3,
                        blurRadius: 2,
                        offset:
                            const Offset(2, 0), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 32.h,
                      horizontal: 24.w,
                    ),
                    child: Column(
                      children: [
                        Gap(12.h),
                        Text(
                          "Daftar Hadir",
                          style: StyleText().openSansTitleBlack,
                        ),
                        Gap(18.h),
                        Expanded(
                          child: ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: attendance.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return ExpansionTilePresence(
                                attendance: attendance[index],
                              );
                            },
                          ),
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
