import 'package:auggy/auggy_repository/auggy_repository.dart';
import 'package:auggy/models/models.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'create_zone_event.dart';
part 'create_zone_state.dart';

class CreateZoneBloc extends Bloc<CreateZoneEvent, CreateZoneState> {
  CreateZoneBloc(this.repository) : super(CreateZoneState()) {
    on<ZoneFormFieldChanged>((event, emit) async {
      switch (event.key) {
        case 'label':
          emit(state.copyWith(label: event.value));
        default:
          print('not yet implemented');
      }
    });
    on<ZoneCreated>((event, emit) async {
      final inserted = await repository.insertZone(event.zone);
    });
  }
  final AuggyRepository repository;
}
