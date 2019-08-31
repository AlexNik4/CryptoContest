import 'app_theme.dart';
import 'managers/authentication_mgr.dart';
import 'respositories/competition_respository.dart';
import 'screens/competitions_screen.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'managers/navigation_mgr.dart';

void main() {
  // Register dependency injection
  GetIt.I.registerSingleton<AuthenticationMgr>(AuthenticationMgr());
  GetIt.I.registerLazySingleton<CompetitionRepository>(() => CompetitionRepository());
  GetIt.I.registerLazySingleton<NavigationMgr>(() => NavigationMgr());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    NavigationMgr navMgr = GetIt.I.get<NavigationMgr>();

    return MaterialApp(
      home: CompetitionsScreen(),
      routes: navMgr.routes,
      navigatorKey: navMgr.navigatorKey,
      onUnknownRoute: navMgr.unknownRoute,
      theme: myTheme,
    );
  }
}
