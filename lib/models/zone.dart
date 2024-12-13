import 'package:auggy/models/foothold.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Zone implements Equatable {
  const Zone({
    required this.start,
    required this.stop,
    required this.label,
    required this.footholds,
  });

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
