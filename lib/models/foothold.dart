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
  void performAction() {}
}

class Foothold implements Equatable {
  Foothold({required this.label, this.icon});

  factory Foothold.fromJson(Map<String, dynamic> json) {
    return Foothold(label: json['label'], icon: json['icon']);
  }

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
class Chore extends Foothold with Memorable, Counter {
  Chore({
    required super.label,
    super.icon,
  });

  factory Chore.fromJson(Map<String, dynamic> json) {
    return Chore(label: json['label'], icon: json['icon']);
  }
}

/// reminder to give yourself something nice, environment UP tap action (play spotify music)
class Boost extends Foothold with Actor {
  Boost({required super.label, super.icon});
}

/// placeholder for meditative time environment DOWN action, prompted to view meditation animation or read a book etc
class Pause extends Foothold with Actor {
  Pause({required super.label, super.icon});
}

/// Effort toward a larger, long-term effort (job, project, hobby, school) with progress / goal / time log tap action
class Contribution extends Foothold with Tracker {
  Contribution({required super.label, super.icon});
}
