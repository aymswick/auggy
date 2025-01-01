import 'package:auggy/day/bloc/day_bloc.dart';
import 'package:auggy/day/view/day_view.dart';
import 'package:auggy/extensions.dart';
import 'package:auggy/main.dart';
import 'package:auggy/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class FootholdTile extends StatelessWidget {
  const FootholdTile({
    super.key,
    required this.zone,
    required this.foothold,
    required this.theme,
  });

  final DeprecatedZone zone;
  final Foothold foothold;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<DayBloc>();
    switch (foothold) {
      case Chore _:
        final chore = foothold as Chore;
        return ListTile(
            title: Row(
              children: [
                FootholdText(foothold),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Chip(
                    label: Text(
                      'Chore'.toUpperCase(),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.amber.onColor,
                          fontFamily: GoogleFonts.bowlbyOneSc().fontFamily),
                    ),
                    backgroundColor: Colors.amber,
                  ),
                ),
              ],
            ),
            onTap: () {
              bloc.add(ChoreCompleted(
                  zone: zone, choreId: chore.id, completed: true));
            });
      case Boost _:
        final boost = foothold as Boost;
        return Row(
          children: [
            FootholdText(foothold),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Chip(
                label: Text(
                  'Boost'.toUpperCase(),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.green.onColor,
                      fontFamily: GoogleFonts.bowlbyOneSc().fontFamily),
                ),
                backgroundColor: Colors.green,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: ElevatedButton.icon(
                  onPressed: () async {
                    await boost.performAction();
                  },
                  icon: Icon(Icons.rocket_launch),
                  label: Text('Launch')),
            )
          ],
        );
      case Ingest _:
        final ingest = foothold as Ingest;
        return Row(
          children: [
            FootholdText(foothold),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Chip(
                label: Text(
                  'Ingest'.toUpperCase(),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.deepOrange.onColor,
                      fontFamily: GoogleFonts.bowlbyOneSc().fontFamily),
                ),
                backgroundColor: Colors.deepOrange,
              ),
            ),
          ],
        );
      default:
        return ListTile(
            leading: foothold.icon,
            title: Align(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  TextButton.icon(
                    onPressed: () => logger.d('tapped ${foothold.label}'),
                    label: FootholdText(foothold),
                  ),
                ],
              ),
            ));
    }
  }
}
