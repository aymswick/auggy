import 'package:auggy/day/bloc/day_bloc.dart';
import 'package:flutter/material.dart';

class DayProgress extends StatelessWidget {
  const DayProgress({required this.state, super.key});

  final DayState state;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final zone = state.day.zones[index];
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(zone.label,
                  style: zone == state.day.currentZone
                      ? theme.textTheme.headlineSmall?.copyWith(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.bold)
                      : theme.textTheme.bodySmall),
            ),
          );
        },
        separatorBuilder: (context, index) => Icon(Icons.arrow_forward_rounded),
        itemCount: state.day.zones.length);
  }
}
