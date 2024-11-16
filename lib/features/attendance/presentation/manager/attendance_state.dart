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

final class GetAttendanceSuccess extends AttendanceState {
  final List<AttendanceEntity>? attendances;
  final AttendanceEntity? attendToday;

  final String? activeWork;
  final bool? isLoading;

  const GetAttendanceSuccess({
    this.attendances = const [],
    this.attendToday,
    this.activeWork,
    this.isLoading = false,
  });

  @override
  List<Object?> get props => [attendances, attendToday, activeWork, isLoading];

  GetAttendanceSuccess copyWith({
    List<AttendanceEntity>? attendances,
    AttendanceEntity? attendToday,
    String? activeWork,
    bool? isLoading,
  }) {
    return GetAttendanceSuccess(
      attendances: attendances ?? this.attendances,
      attendToday: attendToday ?? this.attendToday,
      activeWork: activeWork ?? this.activeWork,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

final class GetAttendanceFailed extends AttendanceState {
  final String message;

  const GetAttendanceFailed(this.message);

  @override
  List<Object?> get props => [message];
}
