import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mabeet_app/models/models.dart';

part 'schedule_state.dart';

class ScheduleCubit extends Cubit<ScheduleState> {
  ScheduleModel schedule = ScheduleModel(wives: {}, outHomeDays: {});

  ScheduleCubit(this.schedule) : super(ScheduleInitial(schedule));
  void addWife({WifeModel? newWife}) {
    //  schedule.wivesStay.add(wife);

    if (schedule.wives.length < 4) {
      if (!schedule.wives.containsKey(newWife!.name)) {
        emit(ScheduleProcess());
        schedule.wives[newWife.name] = newWife;
        emit(ScheduleUpdate());
      } else {
        throw Exception('الزوجة موجود مسبقا');
      }
    } else {
      throw Exception(('لايمكنك اضافة زاوجات اكثر من 4'));
    }
  }

  void updateWives(Map<String, int> wifes) {
    for (var wife in schedule.wives.values) {
      wife.days = wifes[wife.name]!;
    }
    emit(ScheduleUpdate());
  }

  void deleteWife({String wifeName = ''}) {
    if (wifeName.isNotEmpty) {
      if (schedule.wives.containsKey(wifeName)) {
        emit(ScheduleProcess());
        schedule.wives.remove(wifeName);
        emit(ScheduleUpdate());
      }
    }
  }

  void addOuthome(OutHomeModel outDuration) {
    emit(ScheduleProcess());
    schedule.outHomeDays['${outDuration.from.year}${outDuration.from.month}${outDuration.from.day}'] =
        outDuration;
    emit(ScheduleUpdate());
  }
}
