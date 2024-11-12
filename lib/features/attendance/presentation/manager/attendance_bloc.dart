import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/services/connectivity_service.dart';
import '../../../../core/services/device_service.dart';
import '../../../../core/services/token_service.dart';
import '../../data/models/attend_today_model.dart';
import '../../data/models/attendance_model.dart';
import '../../data/models/device_model.dart';
import '../../domain/entities/attendance_entity.dart';
import '../../domain/use_cases/check_in_use_case.dart';
import '../../domain/use_cases/check_out_use_case.dart';

part 'attendance_event.dart';

part 'attendance_state.dart';

class AttendanceBloc extends Bloc<AttendanceEvent, AttendanceState> {
  CheckInUseCase checkInUseCase;

  AttendanceBloc({required this.checkInUseCase}) : super(AttendanceInitial()) {
    on<AttendanceEvent>((event, emit) {});
    on<CheckInEvent>(checkIn);
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

      final attendance = CheckInParam(
        AttendanceModel(
          username: payloadUsername,
          attendToday: attendToday,
        ),
      );
      final checkedIn = await checkInUseCase.call(attendance);
      checkedIn.fold(
        (l) {
          if (l is ServerFailure) {
            emit(CheckInFailed(l.message));
          }
        },
        (r) {
          emit(CheckInSuccess(r));
        },
      );
    } catch (e) {
      emit(const CheckInFailed("Terjadi kesalahan pada sistem"));
    }
  }
}
