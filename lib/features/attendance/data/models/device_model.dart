import '../../domain/entities/device_entity.dart';

class DeviceModel extends DeviceEntity {
  DeviceModel({
    required super.deviceName,
    required super.serialNumber,
    required super.connectionType,
  });

  factory DeviceModel.fromJson(Map<String, dynamic> json) {
    return DeviceModel(
      deviceName: json["device_name"] ?? "",
      serialNumber: json["serial_number"] ?? "",
      connectionType: json["connection_type"] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "device_name": deviceName,
      "serial_number": serialNumber,
      "connection_type": connectionType,
    };
  }
}
