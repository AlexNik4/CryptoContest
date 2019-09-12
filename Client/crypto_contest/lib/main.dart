import 'dart:async';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';

import 'app_theme.dart';
import 'managers/authentication_mgr.dart';
import 'respositories/competition_respository.dart';
import 'screens/competitions_screen.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'managers/navigation_mgr.dart';

void main() {
  // Set `enableInDevMode` to true to see reports while in debug mode
  // This is only to be used for confirming that reports are being
  // submitted as expected. It is not intended to be used for everyday
  // development.
  // Crashlytics.instance.enableInDevMode = true;

  // Pass all uncaught errors from the framework to Crashlytics.
  FlutterError.onError = Crashlytics.instance.recordFlutterError;

  // TODO : Alex - Remove if this is no longer necessary
  // https://groups.google.com/forum/#!msg/flutter-announce/sHAL2fBtJ1Y/mGjrKH3dEwAJ
  WidgetsFlutterBinding.ensureInitialized();

  runZoned<Future<void>>(() async {
    // Register dependency injection
    GetIt.I.registerSingleton<AuthenticationMgr>(AuthenticationMgr());
    GetIt.I.registerLazySingleton<CompetitionRepository>(() => CompetitionRepository());
    GetIt.I.registerLazySingleton<NavigationMgr>(() => NavigationMgr());

    runApp(MyApp());
  }, onError: Crashlytics.instance.recordError);
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    NavigationMgr navMgr = GetIt.I.get<NavigationMgr>();

    return MaterialApp(
      home: CompetitionsScreen(),
      initialRoute: navMgr.initialRoute,
      navigatorKey: navMgr.navigatorKey,
      onGenerateRoute: navMgr.onGenerateRoute,
      theme: myTheme,
    );
  }
}
