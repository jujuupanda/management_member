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
  final List<UserEntity>? listAllUser;

  const ManageAttendanceLoaded({
    this.listAttendanceAllUser = const [],
    this.listAllUser = const [],
  });

  ManageAttendanceLoaded copyWith({
    List<AttendanceEntity>? listAttendanceAllUser,
    List<UserEntity>? listAllUser,
  }) {
    return ManageAttendanceLoaded(
      listAttendanceAllUser:
          listAttendanceAllUser ?? this.listAttendanceAllUser,
      listAllUser: listAllUser ?? this.listAllUser,
    );
  }

  @override
  List<Object?> get props => [listAttendanceAllUser, listAllUser];
}
