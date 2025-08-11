import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mabeet_app/models/models.dart';

part 'schedule_state.dart';

class ScheduleCubit extends Cubit<ScheduleState> {
  ScheduleModel schedule = ScheduleModel(wives: {}, outHomeDays: {});

  ScheduleCubit(this.schedule) : super(ScheduleInitial(schedule));
  void addWife({String? wifeName, int? days, Color? color}) {
    //  schedule.wivesStay.add(wife);
    emit(ScheduleUpdate());
  }

  void updateWifeStays(Map<String, int> wifes) {
    for (var wife in schedule.wives.values) {
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
