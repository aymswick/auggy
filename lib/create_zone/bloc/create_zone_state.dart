part of 'create_zone_bloc.dart';

enum CreateZoneStatus {
  initial,
  success,
  error,
}

class CreateZoneState extends Equatable {
  const CreateZoneState({this.label, this.status});

  final String? label;
  final CreateZoneStatus? status;

  CreateZoneState copyWith({String? label, CreateZoneStatus? status}) =>
      CreateZoneState(
          label: label ?? this.label, status: status ?? this.status);

  @override
  List<Object?> get props => [label, status];
}
