import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'foothold.dart';

class Zone implements Equatable {
  const Zone({
    required this.start,
    required this.stop,
    required this.label,
    required this.footholds,
  });

  factory Zone.fromJson(Map<String, dynamic> json) {
    final start = '${json['start']}'.split(':');
    final stop = '${json['stop']}'.split(':');
    final footholds = json['footholds'];
    return Zone(
      label: json['label'] as String,
      start: TimeOfDay(hour: int.parse(start[0]), minute: int.parse(start[1])),
      stop: TimeOfDay(hour: int.parse(stop[0]), minute: int.parse(stop[1])),
      footholds: footholds ?? [],
    );
  }

  final TimeOfDay start;
  final TimeOfDay stop;
  final String label;
  final List<Foothold> footholds;

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
