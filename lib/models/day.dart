import 'package:auggy/models/models.dart';
import 'package:equatable/equatable.dart';

class Day implements Equatable {
  const Day({required this.zones});

  final List<Zone> zones;

  Zone get currentZone {
    final now = DateTime.now();
    return zones.firstWhere((e) =>
        now.isAfter(e.start.asDateTime()) && now.isBefore(e.stop.asDateTime()));
  }

  Day copyWith({
    List<Zone>? zones,
  }) =>
      Day(
        zones: zones ?? this.zones,
      );

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [zones];
}
