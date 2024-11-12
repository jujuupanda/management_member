part of 'profile_bloc.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();
}

final class ProfileInitial extends ProfileState {
  @override
  List<Object> get props => [];
}

final class ProfileLoading extends ProfileState {
  @override
  List<Object> get props => [];
}

final class GetProfileSuccess extends ProfileState {
  final UserEntity dataUser;

  const GetProfileSuccess(this.dataUser);

  @override
  List<Object?> get props => [dataUser];
}

final class GetProfileFailed extends ProfileState {
  final String message;

  const GetProfileFailed(this.message);

  @override
  List<Object?> get props => [message];
}
