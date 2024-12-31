import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

// A Musician is a Musical Performer

// A Foothold is a Memorable Task

// FootholdType.values.byName(json['type'] as String)

enum FootholdType {
  chore,
  boost,
  pause,
  contribution,
}

mixin Memorable on Foothold {
  final bool canComplete = false;
}

mixin Counter on Foothold {
  void increment() {}

  void decrement() {}
}

mixin Tracker on Foothold {
  void updateProgress() {}
}

mixin Actor on Foothold {
  Future<void> performAction() async {}
}

class Foothold implements Equatable {
  Foothold({required this.id, required this.label, this.icon});

  factory Foothold.fromJson(Map<String, dynamic> json) {
    return Foothold(id: json['id'], label: json['label'], icon: json['icon']);
  }

  final int id;
  final String label;
  late final Icon? icon;

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [
        label,
        icon,
      ];
}

/// repeating checklist items, count and disappear tap action
class Chore extends Foothold with Memorable, Counter, Actor {
  Chore({
    required super.id,
    required super.label,
    super.icon,
  });

  factory Chore.fromJson(Map<String, dynamic> json) =>
      Chore(id: json['id'], label: json['label'], icon: json['icon']);

  bool get isCompletedToday {
    // TODO(ant): getFootholdProgressByUserId
    return false;
  }
}

/// environment UP tap action (play spotify music)
class Boost extends Foothold with Actor {
  Boost({required super.id, required super.label, super.icon});

  factory Boost.fromJson(Map<String, dynamic> json) =>
      Boost(id: json['id'], label: json['label'], icon: json['icon']);
}

/// placeholder for meditative time environment DOWN action, prompted to view meditation animation or read a book etc
class Pause extends Foothold with Actor {
  Pause({required super.id, required super.label, super.icon});
  factory Pause.fromJson(Map<String, dynamic> json) =>
      Pause(id: json['id'], label: json['label'], icon: json['icon']);
}

/// Effort toward a larger, long-term effort (job, project, hobby, school) with progress / goal / time log tap action
class Contribution extends Foothold with Tracker {
  Contribution({required super.id, required super.label, super.icon});

  factory Contribution.fromJson(Map<String, dynamic> json) =>
      Contribution(id: json['id'], label: json['label'], icon: json['icon']);
}

class Ingest extends Foothold with Counter {
  Ingest({required super.id, required super.label, super.icon});

  factory Ingest.fromJson(Map<String, dynamic> json) =>
      Ingest(id: json['id'], label: json['label'], icon: json['icon']);
}
