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
  final List<AttendanceEntity>? listAttendanceAllUser;

  const ManageAttendanceLoaded({
    this.listAttendanceAllUser = const [],
  });

  ManageAttendanceLoaded copyWith({
    List<AttendanceEntity>? listAttendanceAllUser,
  }) {
    return ManageAttendanceLoaded(
      listAttendanceAllUser:
          listAttendanceAllUser ?? this.listAttendanceAllUser,
    );
  }

  @override
  List<Object?> get props => [listAttendanceAllUser];
}
