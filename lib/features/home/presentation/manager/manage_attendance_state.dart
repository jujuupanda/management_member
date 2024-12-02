part of 'manage_attendance_bloc.dart';

sealed class ManageAttendanceState extends Equatable {
  const ManageAttendanceState();
}

final class ManageAttendanceInitial extends ManageAttendanceState {
  @override
  List<Object> get props => [];
}

final class ManageAttendanceLoading extends ManageAttendanceState {
  @override
  List<Object> get props => [];
}

final class ManageAttendanceLoaded extends ManageAttendanceState {
  @override
  List<Object> get props => [];
}