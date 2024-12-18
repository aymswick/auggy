import 'package:auggy/create_zone/bloc/create_zone_bloc.dart';
import 'package:auggy/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateZoneView extends StatefulWidget {
  const CreateZoneView({super.key});

  @override
  State<CreateZoneView> createState() => _CreateZoneViewState();
}

class _CreateZoneViewState extends State<CreateZoneView> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateZoneBloc, CreateZoneState>(
      builder: (context, state) {
        final bloc = context.read<CreateZoneBloc>();
        return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Zone'),
                        onChanged: (value) => bloc.add(
                            ZoneFormFieldChanged(key: 'label', value: value)),
                      ),
                      ElevatedButton.icon(
                          label: Text('Submit'),
                          onPressed: () {
                            if (_formKey.currentState?.validate() ?? false) {
                              bloc.add(ZoneCreated(Zone(
                                  label: state.label!,
                                  start: TimeOfDay.now(),
                                  stop: TimeOfDay.now(),
                                  footholds: [])));
                            }
                          }),
                    ],
                  )),
            ));
      },
    );
  }
}
