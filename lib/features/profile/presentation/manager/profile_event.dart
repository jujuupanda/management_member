part of 'profile_bloc.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();
}

final class GetProfile extends ProfileEvent {
  @override
  List<Object?> get props => [];
}
