part of 'profile_bloc.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();
}

final class ProfileInitial extends ProfileState {
  @override
  List<Object> get props => [];
}

final class ProfileSuccessState extends ProfileState {
  final bool? isLoading;
  final String? messageFailed;
  final UserEntity? dataUser;

  const ProfileSuccessState({
    this.isLoading = false,
    this.messageFailed = "",
    this.dataUser,
  });

  @override
  List<Object?> get props => [isLoading, messageFailed, dataUser];

  ProfileSuccessState copyWith({
    bool? isLoading,
    String? messageFailed,
    UserEntity? dataUser,
  }) {
    return ProfileSuccessState(
      isLoading: isLoading ?? this.isLoading,
      messageFailed: messageFailed ?? this.messageFailed,
      dataUser: dataUser ?? this.dataUser,
    );
  }
}
