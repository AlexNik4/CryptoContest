import 'package:crypto_contest/respositories/competition_respository.dart';
import 'package:crypto_contest/screens/competition_details_screen.dart';
import 'package:crypto_contest/screens/competitions_screen.dart';
import 'package:crypto_contest/screens/page_not_found_screen.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

void main() {
  // Register dependency injection
  GetIt.I.registerLazySingleton<CompetitionRepository>(() => CompetitionRepository());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CompetitionsScreen(),
      routes: {
        CompetitionDetailsScreen.routeName: (context) => CompetitionDetailsScreen(),
      },
      onUnknownRoute: (RouteSettings setting) {
        return MaterialPageRoute(builder: (context) => PageNotFoundScreen());
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
