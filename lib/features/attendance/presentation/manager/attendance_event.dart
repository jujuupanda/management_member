part of 'attendance_bloc.dart';

sealed class AttendanceEvent extends Equatable {
  const AttendanceEvent();
}

final class CheckInEvent extends AttendanceEvent {
  final String typeAttend;
  final File imageFile;

  const CheckInEvent(
    this.typeAttend,
    this.imageFile,
  );

  @override
  List<Object?> get props => [typeAttend, imageFile];
}

final class CheckOutEvent extends AttendanceEvent {
  @override
  List<Object?> get props => [];
}

final class AttendCheckerEvent extends AttendanceEvent {
  @override
  List<Object?> get props => [];
}

final class GetAttendanceEvent extends AttendanceEvent {
  @override
  List<Object?> get props => [];
}
