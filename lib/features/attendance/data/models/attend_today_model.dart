import '../../domain/entities/attend_today_entity.dart';
import 'device_model.dart';

class AttendTodayModel extends AttendTodayEntity {
  AttendTodayModel({
    required super.timeStamp,
    required super.checkIn,
    required super.checkOut,
    required super.location,
    required super.typeAttend,
    required super.photoUrl,
    required super.device,
  });

  factory AttendTodayModel.fromJson(Map<String, dynamic> json) {
    return AttendTodayModel(
      timeStamp: json["time_stamp"],
      checkIn: json["check_in"],
      checkOut: json["check_out"],
      location: json["location"],
      typeAttend: json["type_attend"],
      photoUrl: json["photo_url"],
      device: DeviceModel.fromJson(json["device"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "time_stamp": timeStamp,
      "check_in": checkIn,
      "check_out": checkOut,
      "location": location,
      "type_attend": typeAttend,
      "photo_url": photoUrl,
      "device": (device as DeviceModel).toJson(),
    };
  }
}
