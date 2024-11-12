import 'device_entity.dart';

class AttendTodayEntity {
  final String timeStamp;
  final String checkIn;
  final String checkOut;
  final String location;
  final String typeAttend;
  final String photoUrl;
  final DeviceEntity device;

  const AttendTodayEntity({
    required this.timeStamp,
    required this.checkIn,
    required this.checkOut,
    required this.location,
    required this.typeAttend,
    required this.photoUrl,
    required this.device,
  });
}
