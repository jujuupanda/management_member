import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/utils.dart';
import '../../../attendance/domain/entities/attendance_entity.dart';

class PieChartAttendance extends StatefulWidget {
  const PieChartAttendance({
    super.key,
    required this.attendancePresent,
    required this.attendanceLate,
    required this.attendanceAbsent,
  });

  final List<AttendanceEntity> attendancePresent;
  final List<AttendanceEntity> attendanceLate;
  final List<DateTime> attendanceAbsent;

  @override
  State<PieChartAttendance> createState() => _PieChartAttendanceState();
}

class _PieChartAttendanceState extends State<PieChartAttendance> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.3,
      child: AspectRatio(
        aspectRatio: 1,
        child: PieChart(
          PieChartData(
            pieTouchData: PieTouchData(
              touchCallback: (FlTouchEvent event, pieTouchResponse) {
                setState(() {
                  if (!event.isInterestedForInteractions ||
                      pieTouchResponse == null ||
                      pieTouchResponse.touchedSection == null) {
                    touchedIndex = -1;
                    return;
                  }
                  touchedIndex =
                      pieTouchResponse.touchedSection!.touchedSectionIndex;
                });
              },
            ),
            borderData: FlBorderData(
              show: false,
            ),
            sectionsSpace: 0,
            centerSpaceRadius: 0,
            sections: showingSections(),
          ),
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(3, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 20.0 : 16.0;
      final radius = isTouched ? 110.0 : 100.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];

      switch (i) {
        case 0:
          return PieChartSectionData(
            color: PaletteColor().greenPresence,
            value: widget.attendancePresent.length.toDouble(),
            title: isTouched ? widget.attendancePresent.length.toString() : "",
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
              shadows: shadows,
            ),
          );
        case 1:
          return PieChartSectionData(
            color: PaletteColor().yellowPresence,
            value: widget.attendanceLate.length.toDouble(),
            title: isTouched ? widget.attendanceLate.length.toString() : "",
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
              shadows: shadows,
            ),
          );
        case 2:
          return PieChartSectionData(
            color: PaletteColor().redPresence,
            value: widget.attendanceAbsent.length.toDouble(),
            title: isTouched ? widget.attendanceAbsent.length.toString() : "",
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
              shadows: shadows,
            ),
          );
        default:
          throw Exception('Oh no');
      }
    });
  }
}