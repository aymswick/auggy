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
    return BlocConsumer<CreateZoneBloc, CreateZoneState>(
      listener: (context, state) {
        final sm = ScaffoldMessenger.of(context);
        if (state.status == CreateZoneStatus.error) {
          sm
            ..clearSnackBars()
            ..showSnackBar(SnackBar(content: Text('Error creating zone')));
        } else if (state.status == CreateZoneStatus.success) {
          sm
            ..clearSnackBars()
            ..showSnackBar(
                SnackBar(content: Text('Successfully created zone')));
          Navigator.of(context).pop();
        }
      },
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
                              bloc.add(ZoneCreated(DeprecatedZone(
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
