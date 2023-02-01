import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'error_handler/check_connection/check_connection_bloc.dart';
import 'feature/user/bloc/user_bloc.dart';
import 'feature/user/screens/first_screen.dart';
import 'feature/user/services/user_repository.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => UserRepository(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                UserBloc(userRepository: context.read<UserRepository>()),
          ),
          BlocProvider(create: (context) => CheckConnectionBloc()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: BlocConsumer<CheckConnectionBloc, CheckConnectionState>(
            listener: (context, state) {
              if (state is NotConnectedState) {
                Scaffold(
                  body: Center(
                    child: Text(state.message),
                  ),
                );
              }
            },
            builder: (context, state) {
              if (state is NotConnectedState) {
                return NoConnectionScreen(message: state.message);
              }
              return const FirstScreen();
            },
          ),
        ),
      ),
    );
  }
}

class NoConnectionScreen extends StatelessWidget {
  const NoConnectionScreen({Key? key, required this.message}) : super(key: key);
  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: SafeArea(
        child: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('dissconnect.png', width: 200),
                const SizedBox(height: 30),
                const Text(
                  'There is a problem connecting\nto the Internet',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text(
                  message,
                  style: const TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
