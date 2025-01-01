part of 'day_bloc.dart';

enum DayStatus {
  initial,
}

class DayState extends Equatable {
  const DayState({
    this.status = DayStatus.initial,
    this.day = const Day(
      zones: [],
    ),
  });

  final DayStatus status;
  final Day day;

  DayState copyWith({
    DayStatus? status,
    Day? day,
    DeprecatedZone? currentZone,
  }) =>
      DayState(
        day: day ?? this.day,
        status: status ?? this.status,
      );

  @override
  List<Object?> get props => [
        status,
        day,
      ];
}
