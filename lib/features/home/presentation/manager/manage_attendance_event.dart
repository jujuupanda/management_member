part of 'manage_attendance_bloc.dart';

sealed class ManageAttendanceEvent extends Equatable {
  const ManageAttendanceEvent();
}

final class GetAllAttendanceAllAccount extends ManageAttendanceEvent {
  @override
  List<Object?> get props => [];
}
