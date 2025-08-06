part of 'schedule_cubit.dart';

sealed class ScheduleState extends Equatable {
  const ScheduleState();

  @override
  List<Object> get props => [];
}

final class ScheduleInitial extends ScheduleState {
  const ScheduleInitial(ScheduleModel? schedule);
}

final class ScheduleUpdate extends ScheduleState {
  
}
