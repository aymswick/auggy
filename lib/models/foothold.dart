import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Foothold implements Equatable {
  const Foothold({required this.label, required this.icon});

  final String label;
  final Icon icon;

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [label, icon];
}