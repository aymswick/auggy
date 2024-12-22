import 'package:auggy/create_zone/bloc/create_zone_bloc.dart';
import 'package:auggy/create_zone/view/create_zone.dart';
import 'package:auggy/day/bloc/day_bloc.dart';
import 'package:auggy/day/view/zone_progress_indicator.dart';
import 'package:auggy/extensions.dart';
import 'package:auggy/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:weather_icons/weather_icons.dart';

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

          if (state.day.currentZone != null) {
            _pageViewController.animateToPage(
                state.day.zones.indexOf(state.day.currentZone!),
                duration: Duration(seconds: 2),
                curve: Curves.linear);
          }
        }

        final userEmail = Supabase.instance.client.auth.currentUser?.email;

        return switch (state.status) {
          (DayStatus.initial) => Scaffold(
              appBar: AppBar(
                title: SizedBox(height: 56, child: DayProgress(state: state)),
                centerTitle: true,
                actions: [
                  IconButton(
                      onPressed: () => bloc.add(ZonesFetched()),
                      icon: Icon(Icons.refresh_rounded)),
                  if (userEmail != null)
                    GestureDetector(
                      onLongPress: () {
                        Supabase.instance.client.auth.signOut();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child:
                            CircleAvatar(child: Text(getInitials(userEmail))),
                      ),
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
                              Flexible(
                                  child: Column(
                                children: [
                                  if (state.day.weather != null)
                                    WeatherIndicator(
                                        currentWeather: state.day.weather!),
                                  if (zone == state.day.currentZone)
                                    ZoneProgressIndicator(zone),
                                ],
                              )),
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

class WeatherIndicator extends StatelessWidget {
  const WeatherIndicator({required this.currentWeather, super.key});

  final Map<String, dynamic> currentWeather;
  @override
  Widget build(BuildContext context) {
    final temp = currentWeather['temperature_2m'];
    final feelsLike = currentWeather['apparent_temperature'];
    final code = currentWeather['weather_code'];

    logger.d(currentWeather);
    return Row(
      children: [
        Column(
          children: [
            switch (code) {
              0 => Icon(Icons.wb_sunny), // Clear sky
              1 => Icon(Icons.cloud), // Mainly clear
              2 => Icon(Icons.cloud), // Partly cloudy
              3 => Icon(Icons.cloud), // Overcast
              45 => Icon(Icons.foggy), // Fog
              48 => Icon(Icons.foggy), // Depositing rime fog
              51 => Icon(Icons.grain), // Drizzle: Light intensity
              53 => Icon(Icons.grain), // Drizzle: Moderate intensity
              55 => Icon(Icons.grain), // Drizzle: Dense intensity
              56 => Icon(Icons.ac_unit), // Freezing Drizzle: Light intensity
              57 => Icon(Icons.ac_unit), // Freezing Drizzle: Dense intensity
              61 => Icon(WeatherIcons.rain), // Rain: Slight intensity
              63 => Icon(WeatherIcons.rain), // Rain: Moderate intensity
              65 => Icon(WeatherIcons.rain), // Rain: Heavy intensity
              66 => Icon(Icons.ice_skating), // Freezing Rain: Light intensity
              67 => Icon(Icons.ice_skating), // Freezing Rain: Heavy intensity
              71 => Icon(Icons.snowing), // Snow fall: Slight intensity
              73 => Icon(Icons.snowing), // Snow fall: Moderate intensity
              75 => Icon(Icons.snowing), // Snow fall: Heavy intensity
              77 => Icon(Icons.grain), // Snow grains
              80 => Icon(Icons.shower), // Rain showers: Slight intensity
              81 => Icon(Icons.shower), // Rain showers: Moderate intensity
              82 => Icon(Icons.shower), // Rain showers: Violent intensity
              85 =>
                Icon(Icons.cloudy_snowing), // Snow showers: Slight intensity
              86 => Icon(Icons.cloudy_snowing), // Snow showers: Heavy intensity
              95 =>
                Icon(Icons.thunderstorm), // Thunderstorm: Slight or moderate
              96 => Icon(Icons.thunderstorm), // Thunderstorm with slight hail
              99 => Icon(Icons.thunderstorm), // Thunderstorm with heavy hail
              _ => Icon(Icons.question_mark), // Default (unknown weather)
            },
            Text('Temperature: $temp F'),
            Text('Feels Like: $feelsLike F')
          ],
        ),
      ],
    );
  }
}

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
