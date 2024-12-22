import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';

import 'models.dart';

class Day implements Equatable {
  const Day({required this.zones, this.weather});

  final Map<String, dynamic>? weather;
  final List<Zone> zones;

  Zone? get currentZone {
    final now = DateTime.now();
    return zones.firstWhereOrNull((e) =>
        now.isAfter(e.start.asDateTime()) && now.isBefore(e.stop.asDateTime()));
  }

  Day copyWith({
    List<Zone>? zones,
    Map<String, dynamic>? weather,
  }) =>
      Day(
        zones: zones ?? this.zones,
        weather: weather ?? this.weather,
      );

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [zones, weather];
}
