import 'package:flutter/cupertino.dart';
import '../../../../core/widgets/shimmer_widget.dart';
import 'widget_attendance_recap.dart';

class WidgetShimmerHome {
  attendanceRecapShimmer(){
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ShimmerWidget(
          child: WidgetAttendanceRecap(
            name: "",
            value: "",
            identifiedAs: "present",
          ),
        ),
        ShimmerWidget(
          child: WidgetAttendanceRecap(
            name: "",
            value: "",
            identifiedAs: "late",
          ),
        ),
        ShimmerWidget(
          child: WidgetAttendanceRecap(
            name: "",
            value: "",
            identifiedAs: "absent",
          ),
        ),
      ],
    );
  }
}