import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:rsn_form/pages/rsn_stepper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Required by FlutterConfig

  const bool kReleaseMode =
      bool.fromEnvironment('dart.vm.product', defaultValue: false);

  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.dumpErrorToConsole(details);
    if (kReleaseMode) exit(1);
  };

  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final navKey = new GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    GetIt.I.registerSingleton(navKey, instanceName: 'homePageNavKey');

    return MaterialApp(
        title: 'RSN Mentoring Feedback',
        theme: ThemeData(
          primarySwatch: Colors.green,
          // This makes the visual density adapt to the platform that you run
          // the app on. For desktop platforms, the controls will be smaller and
          // closer together (more dense) than on mobile platforms.
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: RsnStepper(),
        navigatorKey: navKey);
  }
}
