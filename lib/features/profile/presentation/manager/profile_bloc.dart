import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/shared/param/no_param.dart';
import '../../../login/data/models/auth_model.dart';
import '../../data/models/user_model.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/use_cases/add_user_use_case.dart';
import '../../domain/use_cases/edit_profile_use_case.dart';
import '../../domain/use_cases/get_profile_use_case.dart';

part 'profile_event.dart';

part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetProfileUseCase getProfileUseCase;
  final AddUserUseCase addUserUseCase;
  final EditProfileUseCase editProfileUseCase;

  ProfileBloc({
    required this.getProfileUseCase,
    required this.addUserUseCase,
    required this.editProfileUseCase,
  }) : super(ProfileInitial()) {
    on<ProfileEvent>((event, emit) {});
    on<GetProfile>(getProfile);
    on<AddUser>(addUser);
    on<EditProfile>(editProfile);
    on<InitialProfile>(initialProfile);
  }

  getProfile(GetProfile event, Emitter<ProfileState> emit) async {
    final currentState = state is ProfileSuccessState
        ? state as ProfileSuccessState
        : const ProfileSuccessState().copyWith();
    emit(currentState.copyWith(isLoading: true));
    final userData = await getProfileUseCase.call(NoParam());
    userData.fold(
      (l) {
        if (l is ServerFailure) {
          emit(currentState.copyWith(
            isLoading: false,
            messageFailed: l.message,
          ));
        }
      },
      (r) {
        emit(currentState.copyWith(isLoading: false, dataUser: r));
      },
    );
  }

  addUser(AddUser event, Emitter<ProfileState> emit) async {
    final currentState = state is ProfileSuccessState
        ? state as ProfileSuccessState
        : const ProfileSuccessState().copyWith();
    emit(currentState.copyWith(isLoading: true, messageFailed: ""));
    final auth = AuthModel(
      username: event.username.toLowerCase(),
      password: event.password,
      role: event.role,
      jwtToken: "",
      fcmToken: "",
    );
    final user = UserModel(
      username: event.username.toLowerCase(),
      fullName: event.fullName,
      status: "",
      email: "",
      phone: event.phone,
      address: "",
      salary: 0,
      image: "",
      activeWork: event.activeWork,
      division: event.division,
    );
    final userData = await addUserUseCase.call(AddUserParam(user, auth));
    userData.fold(
      (l) {
        if (l is ServerFailure) {
          emit(currentState.copyWith(
            isLoading: false,
            messageFailed: l.message,
          ));
        }
      },
      (r) {
        emit(currentState.copyWith(isLoading: false, messageFailed: ""));
      },
    );
  }

  editProfile(EditProfile event, Emitter<ProfileState> emit) async {
    final currentState = state is ProfileSuccessState
        ? state as ProfileSuccessState
        : const ProfileSuccessState().copyWith();
    emit(currentState.copyWith(isLoading: true));
    final userModel = UserModel(
      username: event.user.username,
      fullName: event.user.fullName,
      status: event.user.status,
      email: event.user.email,
      phone: event.user.phone,
      address: event.user.address,
      salary: event.user.salary,
      image: event.user.image,
      activeWork: event.user.activeWork,
      division: event.user.division,
    );
    final toUpdate = userModel.copyWith(event.object);
    final userUpdated =
        await editProfileUseCase.call(EditProfileParam(toUpdate));
    userUpdated.fold(
      (l) {
        if (l is ServerFailure) {
          emit(currentState.copyWith(
            isLoading: false,
            messageFailed: l.message,
          ));
        }
      },
      (r) {
        emit(currentState.copyWith(isLoading: false, dataUser: r));
      },
    );
  }

  initialProfile(InitialProfile event, Emitter<ProfileState> emit) {
    final currentState = state is ProfileSuccessState
        ? state as ProfileSuccessState
        : const ProfileSuccessState().copyWith();
    emit(currentState.copyWith(messageFailed: ""));
  }
}
