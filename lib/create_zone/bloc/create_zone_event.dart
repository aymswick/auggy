part of 'create_zone_bloc.dart';

sealed class CreateZoneEvent extends Equatable {
  const CreateZoneEvent();

  @override
  List<Object> get props => [];
}

class ZoneCreated extends CreateZoneEvent {
  const ZoneCreated(this.zone);
  final Zone zone;
}

class ZoneFormFieldChanged extends CreateZoneEvent {
  const ZoneFormFieldChanged({required this.key, this.value});
  final String key;
  final String? value;
}
