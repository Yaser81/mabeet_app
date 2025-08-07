import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mabeet_app/models/models.dart';

part 'schedule_state.dart';

class ScheduleCubit extends Cubit<ScheduleState> {
  ScheduleModel schedule = ScheduleModel(wivesStay: [], outHomeDays: {});

  ScheduleCubit(this.schedule) : super(ScheduleInitial(schedule));
  void addWifeStay(WifeStayModel wife) {
    schedule.wivesStay.add(wife);
    emit(ScheduleUpdate());
  }

  void updateWifeStays(Map<String, int> wifes) {
    for (var wife in schedule.wivesStay) {
      wife.days = wifes[wife.name]!;
    }
    emit(ScheduleUpdate());
  }

  void addOuthome(OutHomeModel outDuration) {
    schedule.outHomeDays['${outDuration.from.year}${outDuration.from.month}'] =
        outDuration;
    emit(ScheduleUpdate());
  }
}
