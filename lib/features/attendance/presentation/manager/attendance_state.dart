part of 'attendance_bloc.dart';

sealed class AttendanceState extends Equatable {
  const AttendanceState();
}

final class AttendanceInitial extends AttendanceState {
  @override
  List<Object> get props => [];
}

final class AttendanceLoading extends AttendanceState {
  @override
  List<Object> get props => [];
}

final class AttendSuccess extends AttendanceState {
  final AttendanceEntity attendance;

  const AttendSuccess(this.attendance);

  @override
  List<Object?> get props => [attendance];
}

final class AttendFailed extends AttendanceState {
  final String message;

  const AttendFailed(this.message);

  @override
  List<Object?> get props => [message];
}

final class CheckOutSuccess extends AttendanceState {
  final AttendanceEntity attendance;

  const CheckOutSuccess(this.attendance);
  @override
  List<Object?> get props => [];
}

final class CheckOutFailed extends AttendanceState {
  final String message;

  const CheckOutFailed(this.message);

  @override
  List<Object?> get props => [message];
}

final class AttendCheckerSuccess extends AttendanceState {
  final AttendanceEntity attendance;

  const AttendCheckerSuccess(this.attendance);
  @override
  List<Object?> get props => [];
}

final class AttendCheckerFailed extends AttendanceState {
  final String message;

  const AttendCheckerFailed(this.message);

  @override
  List<Object?> get props => [message];
}
