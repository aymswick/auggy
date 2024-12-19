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

final isLoggedIn = Supabase.instance.client.auth.currentSession != null;
Future<void> main() async {
  await Supabase.initialize(url: supabaseUrl, anonKey: supabaseKey);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Auggy',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            brightness: Brightness.dark, seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: isLoggedIn
          ? BlocProvider(
              create: (context) => DayBloc()..add(PeriodicZoneCheckRequested()),
              child: DayView(),
            )
          : OnboardingView(),
    );
  }
}
