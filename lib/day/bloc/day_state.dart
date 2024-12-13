part of 'day_bloc.dart';

enum DayStatus {
  initial,
}

class DayState extends Equatable {
  const DayState(
      {this.status = DayStatus.initial,
      this.day = const Day(
        zones: hardcodedZones,
      ),
      this.currentZone});

  final DayStatus status;
  final Day day;
  final Zone? currentZone;

  DayState copyWith({
    DayStatus? status,
    Day? day,
    Zone? currentZone,
  }) =>
      DayState(
          day: day ?? this.day,
          status: status ?? this.status,
          currentZone: currentZone ?? this.currentZone);

  @override
  List<Object?> get props => [
        status,
        day,
        currentZone,
      ];
}
