import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

part 'zone.g.dart';

@collection
// ignore: must_be_immutable
class Zone {
  Zone({
    this.id = Isar.autoIncrement,
    required this.name,
    this.start,
    this.end,
  });

  Id id;
  String name;
  @ignore
  TimeOfDay? start;
  @ignore
  TimeOfDay? end;
}
