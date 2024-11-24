part of 'profile_bloc.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();
}

final class GetProfile extends ProfileEvent {
  @override
  List<Object?> get props => [];
}

final class AddUser extends ProfileEvent {
  final String username;
  final String password;
  final String role;
  final String fullName;
  final String division;
  final String phone;
  final String activeWork;

  const AddUser(
    this.username,
    this.password,
    this.role,
    this.fullName,
    this.division,
    this.phone,
    this.activeWork,
  );

  @override
  List<Object?> get props => [
        username,
        password,
        role,
        fullName,
        division,
        phone,
        activeWork,
      ];
}

final class EditProfile extends ProfileEvent {
  final UserEntity user;
  final Map<String, dynamic> object;

  const EditProfile(
    this.user,
    this.object,
  );

  @override
  List<Object?> get props => [user, object];
}

final class ChangePassword extends ProfileEvent {
  final String oldPassword;
  final String newPassword;

  const ChangePassword(
    this.oldPassword,
    this.newPassword,
  );

  @override
  List<Object?> get props => [oldPassword, newPassword];
}

final class InitialProfile extends ProfileEvent {
  @override
  List<Object?> get props => [];
}
