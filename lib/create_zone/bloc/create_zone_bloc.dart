import 'package:auggy/hardcoded/hardcoded.dart';
import 'package:auggy/main.dart';
import 'package:auggy/models/models.dart';
import 'package:auggy/repositories/auggy_repository.dart';
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
          logger.i('not yet implemented');
      }
    });
    on<ZoneCreated>((event, emit) async {
      try {
        logger.d(hardcodedZones.length);
        // for (final zone in hardcodedZones) {
        final inserted = await repository.insertZone(event.zone);
        if (inserted == true) {
          emit(state.copyWith(status: CreateZoneStatus.success));
        }
        // }
      } catch (err) {
        logger.e(err);
        emit(state.copyWith(status: CreateZoneStatus.error));
      }
    });
  }
  final AuggyRepository repository;
}
