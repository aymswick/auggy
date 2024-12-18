import 'package:auggy/day/bloc/day_bloc.dart';
import 'package:auggy/day/view/day_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

const supabaseUrl = 'https://uglvmptoivlulcseejku.supabase.co';
const supabaseKey = String.fromEnvironment('SUPABASE_KEY');

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
      home: BlocProvider(
        create: (context) => DayBloc()..add(PeriodicZoneCheckRequested()),
        child: DayView(),
      ),
    );
  }
}
