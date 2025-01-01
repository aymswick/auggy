import 'package:auggy/create_zone/bloc/create_zone_bloc.dart';
import 'package:auggy/create_zone/view/create_zone.dart';
import 'package:auggy/day/bloc/day_bloc.dart';
import 'package:auggy/day/view/foothold_tile.dart';
import 'package:auggy/day/view/weather_indicator.dart';
import 'package:auggy/day/view/zone_progress_indicator.dart';
import 'package:auggy/extensions.dart';
import 'package:auggy/main.dart';
import 'package:auggy/models/deprecated/foothold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DayView extends StatefulWidget {
  const DayView({super.key});

  @override
  State<DayView> createState() => _DayViewState();
}

class _DayViewState extends State<DayView> {
  late PageController _pageViewController;

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

        final df = DateFormat.yMd();

        return switch (state.status) {
          (DayStatus.initial) => Scaffold(
              appBar: AppBar(
                title: Text(df.format(DateTime.now()).toString()),
                centerTitle: true,
                leading: (state.day.weather != null)
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: WeatherIndicator(
                            currentWeather: state.day.weather!),
                      )
                    : null,
                leadingWidth: 100,
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
              body: Column(
                children: [
                  // DayProgress(state: state, controller: _pageViewController),
                  Expanded(
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
                                children: [
                                  Flexible(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        zone.label,
                                        style: GoogleFonts.bowlbyOneSc(
                                            fontSize: Theme.of(context)
                                                .textTheme
                                                .displayMedium
                                                ?.fontSize),
                                      ),
                                    ),
                                  ),
                                  if (zone == state.day.currentZone)
                                    Flexible(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: ZoneProgressIndicator(zone),
                                      ),
                                    ),
                                ],
                              ),
                              Expanded(
                                child: ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (item, index) {
                                    final foothold = zone.footholds[index];
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: FootholdTile(
                                          zone: zone,
                                          foothold: foothold,
                                          theme: theme),
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
                ],
              ),
            )
        };
      },
    );
  }
}

class FootholdText extends StatelessWidget {
  const FootholdText(this.foothold, {super.key});

  final Foothold foothold;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Text(
      foothold.label,
      style: theme.textTheme.headlineMedium
          ?.copyWith(color: theme.colorScheme.onSurface),
    );
  }
}






// Future<void> turnOnLight() async {
//   final url = Uri.parse('https://developer-api.govee.com/v1/devices/control'); // Replace with the correct endpoint
//   final headers = {
//     'Govee-API-Key': 'your_api_key',
//     'Content-Type': 'application/json',
//   };
//   final body = jsonEncode({
//     'device': 'device_id', 
//     'model': 'device_model',
//     'cmd': {
//       'name': 'turn',
//       'value': 'on',
//     },
//   });
//   final response = await http.put(url, headers: headers, body: body);

//   if (response.statusCode == 200) {
//     // Light turned on successfully
//   } else {
//     // Handle error
//   }
// }