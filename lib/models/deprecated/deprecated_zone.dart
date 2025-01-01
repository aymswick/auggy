import 'package:auggy/main.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'foothold.dart';

class DeprecatedZone implements Equatable {
  const DeprecatedZone({
    required this.start,
    required this.stop,
    required this.label,
    required this.footholds,
  });

  factory DeprecatedZone.fromJson(Map<String, dynamic> json) {
    final start = '${json['start']}'.split(':');
    final stop = '${json['stop']}'.split(':');
    final footholds = (json['footholds'] as List<dynamic>?)?.map((e) {
      return switch (e['type'] as String?) {
        ('chore') => Chore.fromJson(e),
        ('boost') => Boost.fromJson(e),
        ('pause') => Pause.fromJson(e),
        ('contribution') => Contribution.fromJson(e),
        ('ingest') => Ingest.fromJson(e),
        (_) => Foothold.fromJson(e),
      };
    }).toList();

    logger.d(footholds);

    return DeprecatedZone(
      label: '${json['label'] ?? json['zone_label']}',
      start: TimeOfDay(hour: int.parse(start[0]), minute: int.parse(start[1])),
      stop: TimeOfDay(hour: int.parse(stop[0]), minute: int.parse(stop[1])),
      footholds: footholds ?? [],
    );
  }

  final TimeOfDay start;
  final TimeOfDay stop;
  final String label;
  final List<Foothold> footholds;

  DeprecatedZone copyWith(
      {TimeOfDay? start,
      TimeOfDay? stop,
      String? label,
      List<Foothold>? footholds}) {
    return DeprecatedZone(
      label: label ?? this.label,
      start: start ?? this.start,
      stop: stop ?? this.stop,
      footholds: footholds ?? this.footholds,
    );
  }

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [
        label,
        start,
        stop,
        footholds,
      ];
}

extension AsDateTime on TimeOfDay {
  DateTime asDateTime() {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day, hour, minute);
  }
}
