part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();
}

final class AuthInitial extends AuthState {
  @override
  List<Object> get props => [];
}

final class AuthLoading extends AuthState {
  @override
  List<Object> get props => [];
}

final class LoginSuccess extends AuthState {
  final AuthEntity authCredential;

  const LoginSuccess(this.authCredential);

  @override
  List<Object?> get props => [authCredential];
}

final class LoginFailed extends AuthState {
  final String message;

  const LoginFailed(this.message);

  @override
  List<Object?> get props => [message];
}

final class LogoutSuccess extends AuthState {
  @override
  List<Object?> get props => [];
}

final class LogoutFailed extends AuthState {
  @override
  List<Object?> get props => [];
}

final class IsAuth extends AuthState {
  @override
  List<Object?> get props => [];
}

final class UnAuth extends AuthState {
  final String message;

  const UnAuth(this.message);

  @override
  List<Object?> get props => [message];
}
