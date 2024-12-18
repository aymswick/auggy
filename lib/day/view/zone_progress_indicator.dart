import 'package:auggy/extensions.dart';
import 'package:auggy/models/zone.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class ZoneProgressIndicator extends StatelessWidget {
  const ZoneProgressIndicator(this.zone, {super.key});

  final Zone zone;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final totalDuration =
        zone.stop.asDateTime().difference(zone.start.asDateTime()).inMinutes;

    final int timeElapsed =
        zone.stop.asDateTime().difference(DateTime.now()).inMinutes;

    final ratio = timeElapsed / totalDuration;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.timer, color: theme.colorScheme.primary),
            Text(' ${zone.stop.asDateTime().inRoughTime}')
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: LinearPercentIndicator(
            percent: ratio,
            progressColor: theme.colorScheme.primary,
          ),
        )
      ],
    );
  }
}
