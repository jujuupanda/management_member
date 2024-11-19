import 'package:flutter/material.dart';

import '../../../../core/utils/parsing_string.dart';
import '../../../../core/utils/utils.dart';
import '../../../attendance/domain/entities/attendance_entity.dart';
import 'widget_expansion_tile_info.dart';

class ExpansionTilePresence extends StatelessWidget {
  const ExpansionTilePresence({
    super.key,
    required this.attendance,
  });

  final AttendanceEntity attendance;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        ParsingString()
            .formatDateTimeIDFormat(attendance.attendToday.timeStamp),
        style: StyleText().openSansTitleBlack,
      ),
      expandedAlignment: Alignment.centerLeft,
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      backgroundColor: PaletteColor().softBlue5,
      children: [
        WidgetExpansionTileInfo(
          title: "Masuk",
          value: ParsingString()
              .formatDateTimeHHmm(attendance.attendToday.checkIn),
        ),
        WidgetExpansionTileInfo(
          title: "Keluar",
          value: ParsingString()
              .formatDateTimeHHmm(attendance.attendToday.checkOut),
        ),
        WidgetExpansionTileInfo(
          title: "Sistem Kerja",
          value: attendance.attendToday.typeAttend,
        ),
        WidgetExpansionTileInfo(
          title: "Lokasi",
          value: attendance.attendToday.location,
        ),
      ],
    );
  }
}

class ExpansionTilePresenceAbsent extends StatelessWidget {
  const ExpansionTilePresenceAbsent({
    super.key,
    required this.attendance,
  });

  final DateTime attendance;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        ParsingString()
            .formatDateTimeIDFormat(attendance.toString()),
        style: StyleText().openSansTitleBlack,
      ),
      expandedAlignment: Alignment.centerLeft,
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      backgroundColor: PaletteColor().softBlue5,
      children: const [
        WidgetExpansionTileInfo(
          title: "Masuk",
          value: "-",
        ),
        WidgetExpansionTileInfo(
          title: "Keluar",
          value: "-",
        ),
        WidgetExpansionTileInfo(
          title: "Sistem Kerja",
          value: "-",
        ),
        WidgetExpansionTileInfo(
          title: "Lokasi",
          value: "-",
        ),
      ],
    );
  }
}
