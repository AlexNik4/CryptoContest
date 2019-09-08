import 'package:crypto_contest/database_schema/competition.dart';
import 'package:crypto_contest/helpers/enums.dart';
import 'package:crypto_contest/managers/authentication_mgr.dart';
import 'package:crypto_contest/managers/navigation_mgr.dart';
import 'package:crypto_contest/respositories/competition_respository.dart';
import 'package:crypto_contest/view_models/create_competition_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get_it/get_it.dart';

/// The business logic and components for the CreateCompetitionScreen
class CreateCompetitionScreenBloc {
  final _authMgr = GetIt.I.get<AuthenticationMgr>();
  final _repository = GetIt.I.get<CompetitionRepository>();
  final _navMgr = GetIt.I.get<NavigationMgr>();

  final formKey = GlobalKey<FormState>();
  final numberOfCompetitionModes = CompetitionTypes.values.length;

  CreateCompetitionViewModel viewModel = CreateCompetitionViewModel();

  /// Constructor
  CreateCompetitionScreenBloc() {
    // Verify a user is logged in. If not, schedule to navigate to the login screen
    if (!_authMgr.isLoggedIn) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        _navMgr.navigateToAuthenticationScreen().then((value) {
          if (!_authMgr.isLoggedIn) {
            // Pop screen if we still have not logged in
            _navMgr.popScreen();
          }
        });
      });
    }
  }

  String validateTitleValue(String value) {
    if (value.isEmpty) {
      return "Competition title required";
    }
    return null;
  }

  String validatePrizeValue(String value) {
    if (value.isEmpty) {
      return "Value required";
    }
    if (double.tryParse(value) == null) {
      return "Invalid amount";
    }
    return null;
  }

  String validateCoinValue(String value) {
    if (value.isEmpty) {
      return "Select coin";
    }
    // TODO : Alex - Verify it is a currency that is supported by the coin payment processor
    return null;
  }

  String getSelectModeText(int enumIndex) {
    final competitionType = CompetitionTypes.values[enumIndex];
    switch (competitionType) {
      case CompetitionTypes.communityVoted:
        return "Community";
      case CompetitionTypes.creatorDecided:
        return "You";
      case CompetitionTypes.giveaway:
        return "Giveaway";
      default:
        return null;
    }
  }

  IconData getSelectModeIcon(int enumIndex) {
    final competitionType = CompetitionTypes.values[enumIndex];
    switch (competitionType) {
      case CompetitionTypes.communityVoted:
        return Icons.group;
      case CompetitionTypes.creatorDecided:
        return Icons.person;
      case CompetitionTypes.giveaway:
        return Icons.card_giftcard;
      default:
        return null;
    }
  }

  Future<Null> selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: viewModel.selectedEndDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != viewModel.selectedEndDate) {
      // TODO : Alex - Use stream builder to return value
      viewModel.selectedEndDate = picked;
    }
  }

  bool onCreateCompetitionPressed() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      Competition newComp = Competition(
          title: viewModel.title,
          description: viewModel.description,
          duration: viewModel.selectedEndDate.difference(DateTime.now()).inMilliseconds,
          prizeValue: double.parse(viewModel.prizeValue),
          creatorDisplayName: _authMgr.currentUserDetails.value.userDisplayName,
          creatorId: _authMgr.currentUserDetails.value.id,
          coinSymbol: viewModel.coinSymbol);

      _repository.createNewCompetition(newComp);
      return true;
    }
    return false;
  }
}
