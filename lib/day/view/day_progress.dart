import 'package:auggy/day/bloc/day_bloc.dart';
import 'package:flutter/material.dart';

class DayProgress extends StatelessWidget {
  const DayProgress({required this.state, required this.controller, super.key});

  final DayState state;
  final PageController controller;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListView.separated(
        itemBuilder: (context, index) {
          final zone = state.day.zones[index];
          return Center(
            child: TextButton(
              child: Text(zone.label,
                  style: zone == state.day.currentZone
                      ? theme.textTheme.headlineSmall?.copyWith(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.bold)
                      : theme.textTheme.bodySmall),
              onPressed: () => controller.animateToPage(
                  state.day.zones.indexOf(zone),
                  duration: Duration(seconds: 2),
                  curve: Curves.linear),
            ),
          );
        },
        separatorBuilder: (context, index) =>
            Icon(Icons.arrow_downward_rounded),
        itemCount: state.day.zones.length);
  }
}
