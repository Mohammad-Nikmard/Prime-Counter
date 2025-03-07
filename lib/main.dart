import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prime_counter/bloc/prime_bloc.dart';
import 'package:prime_counter/bloc/prime_event.dart';
import 'package:prime_counter/core/DI/locator.dart';
import 'package:prime_counter/ui/home_page.dart';

Future<void> main() async {
  await initServiceLocator();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => PrimeBloc(locator.get(), locator.get())
          ..add(SetPrimeTimerCallerEvent(shouldUpdateTime: false)),
        child: HomePage(),
      ),
    );
  }
}
