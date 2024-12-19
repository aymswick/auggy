import 'package:auggy/main.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  bool isNewUser = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text('Welcome, please sign in or create a new account'),
            LoginSignupView(isNewUser),
            CheckboxListTile(
                title:
                    Text('I am a new user and would like to create an account'),
                value: isNewUser,
                onChanged: (value) => setState(() {
                      isNewUser = value ?? false;
                    }))
          ],
        ),
      ),
    );
  }
}

class LoginSignupView extends StatefulWidget {
  const LoginSignupView(this.isNewUser, {super.key});

  final bool isNewUser;

  @override
  State<LoginSignupView> createState() => _LoginSignupViewState();
}

class _LoginSignupViewState extends State<LoginSignupView> {
  String? _email;
  String? _password;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          decoration: InputDecoration(label: Text('Username')),
          onChanged: (value) => setState(
            () => _email = value,
          ),
        ),
        TextFormField(
          decoration: InputDecoration(label: Text('Password')),
          obscureText: true,
          onChanged: (value) => setState(
            () => _password = value,
          ),
        ),
        ElevatedButton.icon(
          label: Text('Go'),
          icon: Icon(Icons.arrow_forward),
          onPressed: (_email != null &&
                  _email!.isNotEmpty &&
                  _password != null &&
                  _password!.isNotEmpty)
              ? () async {
                  if (widget.isNewUser == true) {
                    final response = await Supabase.instance.client.auth
                        .signUp(email: _email, password: _password!);
                    logger.d(response);
                    if (response.user != null) {
                      ScaffoldMessenger.of(context)
                        ..clearSnackBars()
                        ..showSnackBar(SnackBar(
                            content: Text(
                                'Welcome, ${response.user?.email}, ${response.session}')));
                    }
                  } else {
                    final response = await Supabase.instance.client.auth
                        .signInWithPassword(
                            email: _email, password: _password!);

                    if (response.user != null) {
                      ScaffoldMessenger.of(context)
                        ..clearSnackBars()
                        ..showSnackBar(SnackBar(
                            content: Text(
                                'Welcome, ${response.user?.email}, ${response.session}')));
                    }
                  }
                }
              : null,
        )
      ],
    );
  }
}
