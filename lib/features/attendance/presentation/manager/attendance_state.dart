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
  final bool? isLoadingCheckIn;

  const AttendancesLoaded({
    this.attendances = const [],
    this.attendToday,
    this.activeWork,
    this.isLoading = false,
    this.isLoadingCheckIn = false,
  });

  @override
  List<Object?> get props =>
      [attendances, attendToday, activeWork, isLoading, isLoadingCheckIn];

  AttendancesLoaded copyWith({
    List<AttendanceEntity>? attendances,
    bool removeAttendToday = false,
    AttendanceEntity? attendToday,
    String? activeWork,
    bool? isLoading,
    bool? isLoadingCheckIn,
  }) {
    return AttendancesLoaded(
      attendances: attendances ?? this.attendances,
      attendToday: removeAttendToday ? null : (attendToday ?? this.attendToday),
      activeWork: activeWork ?? this.activeWork,
      isLoading: isLoading ?? this.isLoading,
      isLoadingCheckIn: isLoadingCheckIn ?? this.isLoadingCheckIn,
    );
  }
}
