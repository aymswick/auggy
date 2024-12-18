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
