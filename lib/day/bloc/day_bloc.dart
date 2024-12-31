import 'dart:async';
import 'dart:convert';

import 'package:auggy/models/models.dart';
import 'package:auggy/repositories/auggy_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'day_event.dart';
part 'day_state.dart';

class DayBloc extends Bloc<DayEvent, DayState> {
  DayBloc(this.repository) : super(DayState()) {
    Stream.periodic(const Duration(minutes: 5), (count) {
      return state.day.currentZone;
    }).listen((result) => add(PeriodicZoneCheckRequested()));
    on<ZonesFetched>(
      (event, emit) async {
        final zones = (await repository
                .getZonesByUser(Supabase.instance.client.auth.currentUser!.id))
            .toList();

        final weatherResponse = await http.get(Uri.parse(
            'https://api.open-meteo.com/v1/forecast?latitude=41.85&longitude=-87.65&current=temperature_2m,relative_humidity_2m,apparent_temperature,is_day,weather_code&temperature_unit=fahrenheit&wind_speed_unit=mph&precipitation_unit=inch&forecast_days=1'));

        final weather = jsonDecode(weatherResponse.body);
        emit(state.copyWith(
          day: Day(
            zones: zones,
            weather: (weather as Map<String, dynamic>)['current'],
          ),
        ));
      },
    );
    on<PeriodicZoneCheckRequested>((event, emit) {
      emit(state.copyWith(currentZone: state.day.currentZone));
    });
    on<ChoreCompleted>(
      (event, emit) async {
        final df = DateFormat.yMd();
        await repository.updateFootholdProgress(
            choreId: event.choreId,
            today: df.format(DateTime.now()),
            userId: Supabase.instance.client.auth.currentUser!.id,
            completed: event.completed);

        final zones = state.day.zones;
        final zoneIndex = zones.indexOf(event.zone);
        final foothold =
            event.zone.footholds.firstWhere((e) => e.id == event.choreId);
        final updatedFootholds =
            List.of(zones[zoneIndex].footholds..remove(foothold));

        final updatedZone =
            zones[zoneIndex].copyWith(footholds: updatedFootholds);
        final updatedZones = List.of(zones)
          ..removeAt(zoneIndex)
          ..add(updatedZone);

        emit(state.copyWith(day: state.day.copyWith(zones: updatedZones)));
      },
    );
  }

  @override
  Future<void> close() {
    _currentZoneSubScription?.cancel();
    return super.close();
  }

  StreamSubscription<Zone>? _currentZoneSubScription;
  final AuggyRepository repository;
}
