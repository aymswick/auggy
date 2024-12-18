import 'dart:async';

import 'package:auggy/hardcoded/hardcoded.dart';
import 'package:auggy/models/models.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'day_event.dart';
part 'day_state.dart';

class DayBloc extends Bloc<DayEvent, DayState> {
  DayBloc() : super(DayState()) {
    Stream.periodic(const Duration(minutes: 5), (count) {
      return state.day.currentZone;
    }).listen((result) => add(PeriodicZoneCheckRequested()));

    on<ZonesFetched>(
      (event, emit) async {
        final zones = (await Supabase.instance.client.from('zone').select('*'))
            .map((e) => Zone.fromJson(e))
            .toList();

        emit(state.copyWith(day: Day(zones: zones)));
      },
    );
    on<PeriodicZoneCheckRequested>((event, emit) {
      emit(state.copyWith(currentZone: state.day.currentZone));
    });
  }

  @override
  Future<void> close() {
    _currentZoneSubScription?.cancel();
    return super.close();
  }

  StreamSubscription<Zone>? _currentZoneSubScription;
}
