// ignore_for_file: use_build_context_synchronously

import 'package:auggy/auggy_repository/auggy_repository.dart';
import 'package:auggy/day/bloc/day_bloc.dart';
import 'package:auggy/day/view/day_view.dart';
import 'package:auggy/onboarding/onboarding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

const supabaseUrl = 'https://uglvmptoivlulcseejku.supabase.co';
const supabaseKey =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVnbHZtcHRvaXZsdWxjc2Vlamt1Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzQ1NTA1NjUsImV4cCI6MjA1MDEyNjU2NX0.Q5Q6bSlz-ib7lgv3chxEMJ0nsbb5Yg4NMLlBaHcU830';
final logger = Logger();
final auggyRepo =
    AuggyRepository(client: Supabase.instance.client, logger: logger);

Future<void> main() async {
  await Supabase.initialize(url: supabaseUrl, anonKey: supabaseKey);
  runApp(MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>(); // Create the GlobalKey

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    _setupAuthListener();
  }

  void _setupAuthListener() {
    Supabase.instance.client.auth.onAuthStateChange.listen((data) {
      final event = data.event;
      if (event == AuthChangeEvent.signedOut) {
        navigatorKey.currentState!
            .pushNamedAndRemoveUntil('/login', (route) => false);
      } else if (event == AuthChangeEvent.signedIn) {
        navigatorKey.currentState!.pushReplacementNamed('/home');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        navigatorKey: navigatorKey,
        title: 'Auggy',
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
                brightness: Brightness.dark, seedColor: Colors.green),
            useMaterial3: true,
            inputDecorationTheme:
                InputDecorationTheme(border: OutlineInputBorder())),
        routes: {
          '/login': (context) => OnboardingView(),
          '/home': (context) => BlocProvider(
                create: (context) => DayBloc(auggyRepo)..add(ZonesFetched()),
                child: DayView(),
              ),
        },
        initialRoute: '/login');
  }
}
