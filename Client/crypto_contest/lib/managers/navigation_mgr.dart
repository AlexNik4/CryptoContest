import 'package:crypto_contest/database_schema/competition.dart';
import 'package:crypto_contest/page_routes/scale_page_route.dart';
import 'package:crypto_contest/screens/authentication_screen.dart';
import 'package:crypto_contest/screens/competition_details_screen.dart';
import 'package:crypto_contest/screens/competitions_screen.dart';
import 'package:crypto_contest/screens/create_competition_screen.dart';
import 'package:crypto_contest/screens/page_not_found_screen.dart';
import 'package:crypto_contest/screens/user_profile_screen.dart';
import 'package:flutter/material.dart';

/// Managers the navigation through out the application
class NavigationMgr {
  final initialRoute = _routeHome;
  static const _routeHome = '/';
  static const _routeLoginScreen = '/login';
  static const _routeCompetitionDetails = '/competitionDetails';
  static const _routeCreateCompetitions = '/createCompetitions';
  static const _routeUserDetails = '/userinfo';

  final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

  final Function onGenerateRoute = (RouteSettings settings) {
    switch (settings.name) {
      case _routeHome:
        return MaterialPageRoute(builder: (context) => CompetitionsScreen());
        break;
      case _routeLoginScreen:
        return MaterialPageRoute(builder: (context) => AuthenticationScreen());
        break;
      case _routeCompetitionDetails:
        final CompetitionDetailsScreenArgs args =
            settings.arguments as CompetitionDetailsScreenArgs;
        final test = Alignment.center;
        final test2 = Alignment.bottomRight;
        return ScalePageRoute(
            widget: CompetitionDetailsScreen(args.competition),
            scaleStartLocation: args.animationStartAlignment);
        break;
      case _routeCreateCompetitions:
        return MaterialPageRoute(builder: (context) => CreateCompetitionScreen());
        break;
      case _routeUserDetails:
        return MaterialPageRoute(builder: (context) => UserProfileScreen());
        break;
      default:
        return MaterialPageRoute(builder: (context) => PageNotFoundScreen());
        break;
    }
  };

  /// Navigate back to the previous screen
  void popScreen() {
    if (navigatorKey.currentState.canPop()) {
      navigatorKey.currentState.pop();
    }
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

  Future<dynamic> navigateToUserDetailsScreen() {
    return navigateTo(_routeUserDetails);
  }

  Future<dynamic> navigateToCompetitionDetailsScreen(Competition competition,
      {Alignment animationStartAlignment = Alignment.center}) {
    return navigatorKey.currentState.pushNamed(_routeCompetitionDetails,
        arguments: CompetitionDetailsScreenArgs(competition,
            animationStartAlignment: animationStartAlignment));
  }
}

class CompetitionDetailsScreenArgs {
  final Competition competition;
  final Alignment animationStartAlignment;

  CompetitionDetailsScreenArgs(this.competition, {this.animationStartAlignment = Alignment.center});
}
