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
  final bool? isCreated;
  final bool? isPasswordChanged;
  final String? messageFailed;
  final UserEntity? dataUser;

  const ProfileSuccessState({
    this.isLoading = false,
    this.isCreated = false,
    this.isPasswordChanged = false,
    this.messageFailed = "",
    this.dataUser,
  });

  @override
  List<Object?> get props =>
      [isLoading, isCreated, isPasswordChanged, messageFailed, dataUser];

  ProfileSuccessState copyWith({
    bool? isLoading,
    bool? isCreated,
    bool? isPasswordChanged,
    String? messageFailed,
    UserEntity? dataUser,
  }) {
    return ProfileSuccessState(
      isLoading: isLoading ?? this.isLoading,
      isCreated: isCreated ?? this.isCreated,
      isPasswordChanged: isPasswordChanged ?? this.isPasswordChanged,
      messageFailed: messageFailed ?? this.messageFailed,
      dataUser: dataUser ?? this.dataUser,
    );
  }
}
