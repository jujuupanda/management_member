part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();
}

final class LoginEvent extends AuthEvent {
  final LoginParam params;

  const LoginEvent(this.params);

  @override
  List<Object?> get props => [params];
}

final class LoginCheckerEvent extends AuthEvent {
  @override
  List<Object?> get props => [];
}

final class LogoutEvent extends AuthEvent {
  @override
  List<Object?> get props => [];
}
