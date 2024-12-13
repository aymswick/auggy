import 'package:auggy/models/models.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'day_event.dart';
part 'day_state.dart';

class DayBloc extends Bloc<DayEvent, DayState> {
  DayBloc() : super(DayState()) {
    on<DayEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
