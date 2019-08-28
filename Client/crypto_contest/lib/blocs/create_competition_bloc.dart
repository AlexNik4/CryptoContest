import 'package:crypto_contest/database_schema/competition.dart';
import 'package:crypto_contest/respositories/competition_respository.dart';
import 'package:crypto_contest/view_models/create_competition_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class CreateCompetitionScreenBloc {
  static const communityVotedCompetition = 0;
  static const creatorDecidedCompetition = 1;
  static const giveawayCompetition = 2;

  final _repository = GetIt.I.get<CompetitionRepository>();

  final formKey = GlobalKey<FormState>();
  final numberOfCompetitionModes = 3;

  CreateCompetitionViewModel viewModel = CreateCompetitionViewModel();

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

  String getSelectModeText(int selectedValue) {
    switch (selectedValue) {
      case communityVotedCompetition:
        return "Community";
      case creatorDecidedCompetition:
        return "You";
      case giveawayCompetition:
        return "Giveaway";
      default:
        return null;
    }
  }

  IconData getSelectModeIcon(int selectedValue) {
    switch (selectedValue) {
      case communityVotedCompetition:
        return Icons.group;
      case creatorDecidedCompetition:
        return Icons.person;
      case giveawayCompetition:
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
          // TODO : Alex - Get this from the authentication service
          creatorDisplayName: "",
          creatorId: "",
          coinSymbol: viewModel.coinSymbol);

      _repository.createNewCompetition(newComp);
      return true;
    }
    return false;
  }
}
