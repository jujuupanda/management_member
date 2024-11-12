part of 'attendance_bloc.dart';

sealed class AttendanceEvent extends Equatable {
  const AttendanceEvent();
}

final class CheckInEvent extends AttendanceEvent {
  final String typeAttend;
  final String imagePath;
  final String location;

  const CheckInEvent(
    this.typeAttend,
    this.imagePath,
    this.location,
  );

  @override
  List<Object?> get props => [ typeAttend, imagePath, location];
}

final class CheckOutEvent extends AttendanceEvent {
  final CheckOutParam checkOutParam;

  const CheckOutEvent(this.checkOutParam);

  @override
  List<Object?> get props => [checkOutParam];
}
