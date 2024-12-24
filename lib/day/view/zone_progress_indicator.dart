import 'package:auggy/models/zone.dart';
import 'package:flutter/material.dart';
import 'package:glossy/glossy.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class ZoneProgressIndicator extends StatelessWidget {
  const ZoneProgressIndicator(this.zone, {super.key});

  final Zone zone;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final timeRemaining = zone.stop.asDateTime().difference(DateTime.now());

    final timer = StopWatchTimer(
        mode: StopWatchMode.countDown,
        presetMillisecond:
            timeRemaining.inMilliseconds // millisecond => minute.
        )
      ..onStartTimer();

    return StreamBuilder<int>(
        stream: timer.rawTime,
        initialData: timeRemaining.inMilliseconds,
        builder: (context, snapshot) {
          final displayTime =
              StopWatchTimer.getDisplayTime(snapshot.data!, milliSecond: false);
          return GlossyContainer(
            height: 60,
            width: MediaQuery.sizeOf(context).width - 100,
            border: Border.all(),
            borderRadius: BorderRadius.circular(12),
            gradient: GlossyLinearGradient(colors: [
              theme.colorScheme.primary,
              theme.colorScheme.primaryContainer
            ], opacity: .75),
            child: Center(
              child: Text(
                displayTime,
                style: GoogleFonts.pressStart2p(
                    fontSize: theme.textTheme.headlineLarge?.fontSize),
              ),
            ),
          );
        });
  }
}
