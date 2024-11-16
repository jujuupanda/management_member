import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/services/connectivity_service.dart';
import '../../../../core/services/device_service.dart';
import '../../../../core/services/secure_storage_service.dart';
import '../../../../core/services/token_service.dart';
import '../../../../core/shared/param/no_param.dart';
import '../../data/models/attend_today_model.dart';
import '../../data/models/attendance_model.dart';
import '../../data/models/device_model.dart';
import '../../domain/entities/attendance_entity.dart';
import '../../domain/use_cases/attend_checker_use_case.dart';
import '../../domain/use_cases/check_in_use_case.dart';
import '../../domain/use_cases/check_out_use_case.dart';
import '../../domain/use_cases/get_attendance_use_case.dart';

part 'attendance_event.dart';

part 'attendance_state.dart';

class AttendanceBloc extends Bloc<AttendanceEvent, AttendanceState> {
  CheckInUseCase checkInUseCase;
  CheckOutUseCase checkOutUseCase;
  AttendCheckerUseCase attendCheckerUseCase;
  GetAttendanceUseCase getAttendanceUseCase;

  AttendanceBloc({
    required this.checkInUseCase,
    required this.checkOutUseCase,
    required this.attendCheckerUseCase,
    required this.getAttendanceUseCase,
  }) : super(AttendanceInitial()) {
    on<AttendanceEvent>((event, emit) {});
    on<CheckInEvent>(checkIn);
    on<CheckOutEvent>(checkOut);
    on<AttendCheckerEvent>(attendChecker);
    on<GetAttendanceEvent>(getAttendance);
  }

  checkIn(event, emit) async {
    emit(AttendanceLoading());
    // emit((state as GetAttendanceSuccess).copyWith(isLoading: true));
    // get info
    final deviceInfo = await DeviceService().getDeviceInfo();
    final connectivityInfo = await ConnectivityService().getConnectivityInfo();

    //get username
    final payloadUsername = await TokenService().jwtPayloadUsername();

    //device
    final device = DeviceModel(
      deviceName: deviceInfo["product"].toString(),
      serialNumber: deviceInfo["serialNumber"].toString(),
      connectionType: connectivityInfo.toString(),
    );

    //attendance
    final attendToday = AttendTodayModel(
      timeStamp: DateTime.now().toString(),
      checkIn: DateTime.now().toString(),
      checkOut: "",
      location: event.location,
      typeAttend: event.typeAttend,
      photoUrl: event.imagePath,
      device: device,
    );

    final checkInParam = CheckInParam(
      AttendanceModel(
        username: payloadUsername,
        attendToday: attendToday,
      ),
    );
    final checkedIn = await checkInUseCase.call(checkInParam);
    checkedIn.fold(
      (l) {
        if (l is ServerFailure) {
          print("check in l");
          emit(GetAttendanceFailed(l.message));
        }
      },
      (r) {
        print("check in r");
        final currentState = state is GetAttendanceSuccess
            ? state as GetAttendanceSuccess
            : const GetAttendanceSuccess(attendances: []);
        emit(currentState.copyWith(attendToday: r, isLoading: false));
      },
    );
  }

  checkOut(event, emit) async {
    emit(AttendanceLoading());
    // emit((state as GetAttendanceSuccess).copyWith(isLoading: true));
    final checkOutParam = CheckOutParam(DateTime.now().toString());
    final checkedOut = await checkOutUseCase.call(checkOutParam);
    checkedOut.fold(
      (l) {
        print("check out l");
        if (l is ServerFailure) {
          emit(GetAttendanceFailed(l.message));
        }
      },
      (r) {
        print("check out r");
        final currentState = state is GetAttendanceSuccess
            ? state as GetAttendanceSuccess
            : const GetAttendanceSuccess(attendances: []);
        emit(currentState.copyWith(attendToday: r, isLoading: false));
      },
    );
  }

  attendChecker(event, emit) async {
    emit(AttendanceLoading());
    // emit((state as GetAttendanceSuccess).copyWith(isLoading: true));
    final attendedChecker = await attendCheckerUseCase.call(NoParam());
    attendedChecker.fold(
      (l) {
        print("attend checker l");

        final currentState = state is GetAttendanceSuccess
            ? state as GetAttendanceSuccess
            : const GetAttendanceSuccess(attendances: []);
        emit(currentState.copyWith( isLoading: false));
      },
      (r) {
        print("attend checker r");

        final currentState = state is GetAttendanceSuccess
            ? state as GetAttendanceSuccess
            : const GetAttendanceSuccess(attendances: []);
        emit(currentState.copyWith(attendToday: r, isLoading: false));
      },
    );
  }

  getAttendance(event, emit) async {
    emit(AttendanceLoading());
    // emit((state as GetAttendanceSuccess).copyWith(isLoading: true));
    final getAttendances = getAttendanceUseCase.call(NoParam());
    await getAttendances.forEach(
      (element) => element.fold(
        (l) {
          if (l is ServerFailure) {
            print("get attend l");
            emit(GetAttendanceFailed(l.message));
          }
        },
        (r) {
          print("get attend r");
          final currentState = state is GetAttendanceSuccess
              ? state as GetAttendanceSuccess
              : const GetAttendanceSuccess(attendances: []);
          emit(currentState.copyWith(attendances: r, isLoading: false));
        },
      ),
    );
  }
}
