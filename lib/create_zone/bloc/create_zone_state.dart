part of 'create_zone_bloc.dart';

class CreateZoneState extends Equatable {
  const CreateZoneState({this.label});

  final String? label;

  CreateZoneState copyWith({String? label}) =>
      CreateZoneState(label: label ?? this.label);

  @override
  List<Object?> get props => [label];
}
