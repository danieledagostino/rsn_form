import 'dart:io';
import 'package:flutter/foundation.dart';
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
  Future<bool> _storeInit = Init.initialize();

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
        home: FutureBuilder<bool>(
            future: _storeInit,
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return HomeMenu();
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.lightBlueAccent,
                  ),
                );
              } else {
                if (snapshot.hasError) {
                  return Container(
                    child: Column(
                      children: [
                        Text('Errors has occurred'),
                        Text(snapshot.error)
                      ],
                    ),
                  );
                }
              }
            }),
        navigatorKey: navKey);
  }
}
