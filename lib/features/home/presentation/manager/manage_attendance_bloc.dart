import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/shared/param/no_param.dart';
import '../../domain/use_cases/get_all_attendance_use_case.dart';

part 'manage_attendance_event.dart';

part 'manage_attendance_state.dart';

class ManageAttendanceBloc
    extends Bloc<ManageAttendanceEvent, ManageAttendanceState> {
  GetAllAttendanceUseCase getAllAttendanceUseCase;

  ManageAttendanceBloc({
    required this.getAllAttendanceUseCase,
  }) : super(ManageAttendanceInitial()) {
    on<ManageAttendanceEvent>((event, emit) {});
    on<GetAllAttendanceAllAccount>(getAllAttendanceAllAccount);
  }

  getAllAttendanceAllAccount(ManageAttendanceEvent event, Emitter emit) async {
    final getAllAttendance = getAllAttendanceUseCase.call(NoParam());
    await getAllAttendance.forEach(
      (element) => element.fold(
        (l) => emit(ManageAttendanceLoaded()),
        (r) => emit(ManageAttendanceLoaded()),
      ),
    );
  }
}
