import 'package:auggy/day/bloc/day_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DayView extends StatelessWidget {
  const DayView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DayBloc, DayState>(
      builder: (context, state) {
        return switch (state.status) {
          (DayStatus.initial) => Scaffold(
              appBar: AppBar(),
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.day.zones.length,
                  itemBuilder: (context, index) {
                    final theme = Theme.of(context);
                    final zone = state.day.zones[index];
                    final now = DateTime.now();

                    final isActiveZone = now.isAfter(DateTime(
                            now.year,
                            now.month,
                            now.day,
                            zone.start.hour,
                            zone.start.minute)) &&
                        now.isBefore(DateTime(now.year, now.month, now.day,
                            zone.stop.hour, zone.stop.minute));

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: isActiveZone
                                ? BoxDecoration(
                                    border: Border.all(
                                    width: 2,
                                    color: theme.colorScheme.primary,
                                  ))
                                : null,
                            child: Row(
                              children: [
                                Flexible(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      zone.label,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium,
                                    ),
                                  ),
                                ),
                                if (isActiveZone)
                                  Flexible(
                                      child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(Icons.arrow_circle_left_rounded,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary),
                                  ))
                              ],
                            ),
                          ),
                          ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (item, index) {
                              final foothold = zone.footholds[index];
                              return ListTile(
                                  leading: foothold.icon,
                                  title: Text(foothold.label));
                            },
                            itemCount: zone.footholds.length,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            )
        };
      },
    );
  }
}
