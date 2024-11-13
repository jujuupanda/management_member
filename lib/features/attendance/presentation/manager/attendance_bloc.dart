import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/services/connectivity_service.dart';
import '../../../../core/services/device_service.dart';
import '../../../../core/services/token_service.dart';
import '../../../../core/shared/param/no_param.dart';
import '../../data/models/attend_today_model.dart';
import '../../data/models/attendance_model.dart';
import '../../data/models/device_model.dart';
import '../../domain/entities/attendance_entity.dart';
import '../../domain/use_cases/attend_checker_use_case.dart';
import '../../domain/use_cases/check_in_use_case.dart';
import '../../domain/use_cases/check_out_use_case.dart';

part 'attendance_event.dart';

part 'attendance_state.dart';

class AttendanceBloc extends Bloc<AttendanceEvent, AttendanceState> {
  CheckInUseCase checkInUseCase;
  CheckOutUseCase checkOutUseCase;
  AttendCheckerUseCase attendCheckerUseCase;

  AttendanceBloc({
    required this.checkInUseCase,
    required this.checkOutUseCase,
    required this.attendCheckerUseCase,
  }) : super(AttendanceInitial()) {
    on<AttendanceEvent>((event, emit) {});
    on<CheckInEvent>(checkIn);
    on<CheckOutEvent>(checkOut);
    on<AttendCheckerEvent>(attendChecker);
  }

  checkIn(CheckInEvent event, Emitter emit) async {
    emit(AttendanceLoading());
    try {
      // get info
      final deviceInfo = await DeviceService().getDeviceInfo();
      final connectivityInfo =
          await ConnectivityService().getConnectivityInfo();

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
            emit(AttendFailed(l.message));
          }
        },
        (r) {
          emit(AttendSuccess(r));
        },
      );
    } catch (e) {
      emit(const AttendFailed("Terjadi kesalahan pada sistem"));
    }
  }

  checkOut(CheckOutEvent event, Emitter emit) async {
    emit(AttendanceLoading());
    try {
      final checkOutParam = CheckOutParam(DateTime.now().toString());
      final checkedOut = await checkOutUseCase.call(checkOutParam);
      checkedOut.fold(
        (l) {
          if (l is ServerFailure) {
            emit(AttendFailed(l.message));
          }
        },
        (r) {
          emit(AttendSuccess(r));
        },
      );
    } catch (e) {
      emit(const AttendFailed("Terjadi kesalahan pada sistem"));
    }
  }

  attendChecker(AttendCheckerEvent event, Emitter emit) async {
    emit(AttendanceLoading());
    try {
      final attendedChecker = await attendCheckerUseCase.call(NoParam());
      attendedChecker.fold(
        (l) {
          if (l is ServerFailure) {
            emit(AttendCheckerFailed(l.message));
          }
        },
        (r) {
          emit(AttendCheckerSuccess(r));
        },
      );
    } catch (e) {
      emit(const AttendCheckerFailed("Terjadi kesalahan pada sistem"));
    }
  }
}
