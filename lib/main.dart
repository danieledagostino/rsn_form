import 'dart:io';
import 'package:flutter/material.dart';
import 'package:rsn_form/dao/init.dart';
import 'package:rsn_form/pages/home_menu.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Required by FlutterConfig
  HttpOverrides.global = new MyHttpOverrides();

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
    return MaterialApp(
        title: 'RSN',
        theme: ThemeData(
          primarySwatch: Colors.green,
          // This makes the visual density adapt to the platform that you run
          // the app on. For desktop platforms, the controls will be smaller and
          // closer together (more dense) than on mobile platforms.
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: FutureBuilder<void>(
            future: Init.initialize(),
            builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return HomeMenu();
              }
            }),
        navigatorKey: navKey);
  }
}
