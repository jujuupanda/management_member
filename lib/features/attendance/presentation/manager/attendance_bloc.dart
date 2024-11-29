import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/connectivity_service.dart';
import '../../../../core/services/device_service.dart';
import '../../../../core/services/geo_location_service.dart';
import '../../../../core/services/secure_storage_service.dart';
import '../../../../core/services/token_service.dart';
import '../../../../core/shared/param/no_param.dart';
import '../../../../core/utils/utils.dart';
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

  checkIn(CheckInEvent event,Emitter<AttendanceState> emit) async {
    final currentState = state is AttendancesLoaded
        ? state as AttendancesLoaded
        : const AttendancesLoaded();
    emit(currentState.copyWith(isLoading: true, isLoadingCheckIn: true));
    // get info
    final deviceInfo = await DeviceService().getDeviceInfo();
    final connectivityInfo = await ConnectivityService().getConnectivityInfo();
    final locationInfo =
        await GeoLocationService().getCurrentLocationNoContext();
    final photoUrl = await PickImage()
        .uploadImage(event.imageFile, "attendance");
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
      location: "${locationInfo.latitude}, ${locationInfo.longitude}",
      typeAttend: event.typeAttend,
      photoUrl: photoUrl,
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
        emit(currentState.copyWith(
          isLoading: false,
          isLoadingCheckIn: false,
        ));
      },
      (r) {
        emit(currentState.copyWith(
          attendToday: r,
          isLoading: false,
          isLoadingCheckIn: false,
        ));
        add(GetAttendanceEvent());
      },
    );
  }

  checkOut(event, emit) async {
    final currentState = state is AttendancesLoaded
        ? state as AttendancesLoaded
        : const AttendancesLoaded();

    emit(currentState.copyWith(isLoading: true));
    final checkOutParam = CheckOutParam(DateTime.now().toString());
    final checkedOut = await checkOutUseCase.call(checkOutParam);
    checkedOut.fold(
      (l) {
        emit(currentState.copyWith(
          isLoading: false,
        ));
      },
      (r) {
        emit(currentState.copyWith(
          attendToday: r,
          isLoading: false,
        ));
        add(GetAttendanceEvent());
      },
    );
  }

  attendChecker(event, emit) async {
    final currentState = state is AttendancesLoaded
        ? state as AttendancesLoaded
        : const AttendancesLoaded();

    emit(currentState.copyWith(isLoading: true));
    final attendedChecker = attendCheckerUseCase.call(NoParam());
    await attendedChecker.forEach((element) => element.fold(
          (l) {
            emit(currentState.copyWith(
              removeAttendToday: true,
              isLoading: false,
            ));
          },
          (r) {
            emit(currentState.copyWith(
              attendToday: r,
              isLoading: false,
            ));
          },
        ));
  }

  getAttendance(event, emit) async {
    final currentState = state is AttendancesLoaded
        ? state as AttendancesLoaded
        : const AttendancesLoaded();
    final activeWork =
        await SecureStorageService().retrieveString("activeWork");

    emit(currentState.copyWith(isLoading: true));

    final getAttendances = getAttendanceUseCase.call(NoParam());
    await getAttendances.forEach(
      (element) => element.fold(
        (l) {
          emit(currentState.copyWith(
            isLoading: false,
            activeWork: activeWork,
          ));
        },
        (r) {
          List<AttendanceEntity> attendToday = r
              .where(
                (element) =>
                    ParsingString()
                        .parsingTimeToYMD(element.attendToday.timeStamp) ==
                    ParsingString().parsingTimeToYMD(DateTime.now().toString()),
              )
              .toList();
          emit(currentState.copyWith(
            attendances: r,
            attendToday: attendToday.isNotEmpty ? attendToday.first : null,
            isLoading: false,
            activeWork: activeWork,
          ));
        },
      ),
    );
  }
}
