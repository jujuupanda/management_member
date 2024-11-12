import 'attend_today_entity.dart';

class AttendanceEntity {
  final String username;
  final AttendTodayEntity attendToday;

  AttendanceEntity({
    required this.username,
    required this.attendToday,
  });
}
