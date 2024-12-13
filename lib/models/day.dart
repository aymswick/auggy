import 'package:auggy/models/models.dart';
import 'package:equatable/equatable.dart';

class Day implements Equatable {
  const Day({required this.zones});

  final List<Zone> zones;

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [zones];
}
