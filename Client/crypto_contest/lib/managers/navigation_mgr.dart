import 'package:crypto_contest/database_schema/competition.dart';
import 'package:crypto_contest/screens/authentication_screen.dart';
import 'package:crypto_contest/screens/competition_details_screen.dart';
import 'package:crypto_contest/screens/create_competition_screen.dart';
import 'package:crypto_contest/screens/page_not_found_screen.dart';
import 'package:flutter/material.dart';

/// Managers the navigation through out the application
class NavigationMgr {
  static const _routeLoginScreen = '/login';
  static const _routeCompetitionDetails = '/competitionDetails';
  static const _routeCreateCompetitions = '/createCompetitions';

  final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();
  final Map<String, Widget Function(BuildContext)> routes = {
    _routeLoginScreen: (context) => AuthenticationScreen(),
    _routeCompetitionDetails: (context) => CompetitionDetailsScreen(),
    _routeCreateCompetitions: (context) => CreateCompetitionScreen(),
  };

  final Function unknownRoute = (RouteSettings setting) {
    return MaterialPageRoute(builder: (context) => PageNotFoundScreen());
  };

  /// Navigate back to the previous screen
  void popScreen() {
    navigatorKey.currentState.pop();
  }

  Future<dynamic> navigateTo(String routeName) {
    return navigatorKey.currentState.pushNamed(routeName);
  }

  Future<dynamic> navigateToAuthenticationScreen() {
    return navigateTo(_routeLoginScreen);
  }

  Future<dynamic> navigateToCreateCompetitionScreen() {
    return navigateTo(_routeCreateCompetitions);
  }

  Future<dynamic> navigateToCompetitionDetailsScreen(Competition competition) {
    return navigatorKey.currentState.pushNamed(
      _routeCompetitionDetails,
      arguments: competition,
    );
  }
}
