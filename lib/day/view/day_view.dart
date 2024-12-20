import 'package:auggy/create_zone/bloc/create_zone_bloc.dart';
import 'package:auggy/create_zone/view/create_zone.dart';
import 'package:auggy/day/bloc/day_bloc.dart';
import 'package:auggy/day/view/zone_progress_indicator.dart';
import 'package:auggy/extensions.dart';
import 'package:auggy/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DayView extends StatefulWidget {
  const DayView({super.key});

  @override
  State<DayView> createState() => _DayViewState();
}

class _DayViewState extends State<DayView> {
  late PageController _pageViewController;
  bool? isCastConnected;

  @override
  void initState() {
    super.initState();

    _pageViewController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _pageViewController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<DayBloc>();
    return BlocBuilder<DayBloc, DayState>(
      builder: (context, state) {
        if (_pageViewController.hasClients) {
          logger.d('Moving to ${state.day.currentZone?.label}');

          if (state.currentZone != null) {
            _pageViewController.animateToPage(
                state.day.zones.indexOf(state.day.currentZone!),
                duration: Duration(seconds: 2),
                curve: Curves.linear);
          }
        }
        return switch (state.status) {
          (DayStatus.initial) => Scaffold(
              appBar: AppBar(
                title:
                    Text('${Supabase.instance.client.auth.currentUser?.email}'),
                actions: [
                  IconButton(
                      onPressed: () => bloc.add(ZonesFetched()),
                      icon: Icon(Icons.refresh_rounded)),
                  GestureDetector(
                    onLongPress: () {
                      Supabase.instance.client.auth.signOut();
                    },
                    child: CircleAvatar(
                        child: Text(getInitials(
                            Supabase.instance.client.auth.currentUser?.email ??
                                'huh'))),
                  )
                ],
              ),
              floatingActionButton: FloatingActionButton.extended(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return BlocProvider(
                          create: (context) => CreateZoneBloc(
                            auggyRepo,
                          ),
                          child: CreateZoneView(),
                        );
                      }),
                    );
                  },
                  label: Text('Create Zone')),
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: PageView.builder(
                  controller: _pageViewController,
                  scrollDirection: Axis.vertical,
                  physics: PageScrollPhysics(),
                  itemCount: state.day.zones.length,
                  itemBuilder: (context, index) {
                    final theme = Theme.of(context);
                    final zone = state.day.zones[index];

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    zone.label,
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayLarge,
                                  ),
                                ),
                              ),
                              if (zone == state.day.currentZone)
                                Flexible(child: ZoneProgressIndicator(zone)),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (item, index) {
                                final foothold = zone.footholds[index];
                                return ListTile(
                                  leading: foothold.icon,
                                  title: Text(foothold.label,
                                      style: theme.textTheme.displaySmall),
                                );
                              },
                              itemCount: zone.footholds.length,
                            ),
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
