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

final class CheckInSuccess extends AttendanceState {
  final AttendanceEntity attendance;

  const CheckInSuccess(this.attendance);

  @override
  List<Object?> get props => [attendance];
}

final class CheckInFailed extends AttendanceState {
  final String message;

  const CheckInFailed(this.message);

  @override
  List<Object?> get props => [message];
}

final class CheckOutSuccess extends AttendanceState {
  @override
  List<Object?> get props => throw UnimplementedError();
}

final class CheckOutFailed extends AttendanceState {
  @override
  List<Object?> get props => throw UnimplementedError();
}
