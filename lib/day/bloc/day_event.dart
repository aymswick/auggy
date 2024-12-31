part of 'day_bloc.dart';

sealed class DayEvent extends Equatable {
  const DayEvent();

  @override
  List<Object> get props => [];
}

class ZonesFetched extends DayEvent {
  const ZonesFetched();
}

class PeriodicZoneCheckRequested extends DayEvent {
  const PeriodicZoneCheckRequested();
}

class ChoreCompleted extends DayEvent {
  const ChoreCompleted(
      {required this.zone, required this.choreId, required this.completed});
  final Zone zone;
  final int choreId;
  final bool completed;
}
