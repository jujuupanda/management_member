import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/services/secure_storage_service.dart';
import '../../../../core/shared/param/no_param.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/use_cases/get_profile_use_case.dart';

part 'profile_event.dart';

part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetProfileUseCase getProfileUseCase;

  ProfileBloc({required this.getProfileUseCase}) : super(ProfileInitial()) {
    on<ProfileEvent>((event, emit) {});
    on<GetProfile>(getProfile);
  }

  getProfile(ProfileEvent event, Emitter emit) async {
    emit(ProfileLoading());
    try {
      final userData = await getProfileUseCase.call(NoParam());
      userData.fold(
        (l) {
          if (l is ServerFailure) {
            emit(GetProfileFailed(l.message));
          }
        },
        (r) {
          SecureStorageService().saveString("activeWork", r.activeWork);
          emit(GetProfileSuccess(r));
        },
      );
    } catch (e) {
      emit(const GetProfileFailed("Terjadi kesalahan sistem"));
    }
  }
}
