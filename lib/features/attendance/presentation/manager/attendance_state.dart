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

final class AttendancesLoaded extends AttendanceState {
  final List<AttendanceEntity>? attendances;
  final AttendanceEntity? attendToday;
  final String? activeWork;
  final bool? isLoading;

  const AttendancesLoaded({
    this.attendances = const [],
    this.attendToday,
    this.activeWork,
    this.isLoading = false,
  });

  @override
  List<Object?> get props => [attendances, attendToday, activeWork, isLoading];

  AttendancesLoaded copyWith({
    List<AttendanceEntity>? attendances,
    bool removeAttendToday = false,
    AttendanceEntity? attendToday,
    String? activeWork,
    bool? isLoading,
  }) {
    return AttendancesLoaded(
      attendances: attendances ?? this.attendances,
      attendToday: removeAttendToday ? null : (attendToday ?? this.attendToday),
      activeWork: activeWork ?? this.activeWork,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
