import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/shared/param/no_param.dart';
import '../../domain/entities/auth_entity.dart';
import '../../domain/use_cases/login_checker_use_case.dart';
import '../../domain/use_cases/login_use_case.dart';
import '../../domain/use_cases/logout_use_case.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  LoginUseCase loginUseCase;
  LoginCheckerUseCase loginCheckerUseCase;
  LogoutUseCase logoutUseCase;

  AuthBloc({
    required this.loginUseCase,
    required this.logoutUseCase,
    required this.loginCheckerUseCase,
  }) : super(AuthInitial()) {
    on<AuthEvent>((event, emit) {});
    on<LoginCheckerEvent>(loginChecker);
    on<LoginEvent>(login);
    on<LogoutEvent>(logout);
  }

  loginChecker(LoginCheckerEvent event, Emitter emit) async {
    emit(AuthLoading());
    try {
      final loginChecked =
          await loginCheckerUseCase.repository.loginChecker(NoParam());
      loginChecked.fold(
        (l) {
          if (l is CacheFailure) {
            emit(UnAuth(l.message));
          }
        },
        (r) => emit(IsAuth()),
      );
    } catch (e) {
      throw Exception(e);
    }
  }

  login(LoginEvent event, Emitter emit) async {
    emit(AuthLoading());
    final authCred = await loginUseCase.repository.login(event.params);
    authCred.fold((l) {
      if (l is ServerFailure) {
        emit(LoginFailed(l.message));
      }
    }, (r) {
      emit(LoginSuccess(r));
    });
  }

  logout(LogoutEvent event, Emitter emit) async {
    emit(AuthLoading());
    final logout = await logoutUseCase.repository.logout(NoParam());
    logout.fold((l) {
      if (l is ServerFailure) {
        emit(LogoutFailed());
      }
    }, (r) {
      emit(LogoutSuccess());
    });
  }
}
