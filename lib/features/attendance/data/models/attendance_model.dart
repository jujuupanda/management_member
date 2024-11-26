import '../../domain/entities/attendance_entity.dart';
import 'attend_today_model.dart';

class AttendanceModel extends AttendanceEntity {
  AttendanceModel({
    required super.username,
    required super.attendToday,
  });

  factory AttendanceModel.fromJson(Map<String, dynamic> json) {
    return AttendanceModel(
      username: json["username"] ?? "",
      attendToday: AttendTodayModel.fromJson(json["attend_today"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "username": username,
      "attend_today": (attendToday as AttendTodayModel).toJson(),
    };
  }
}
