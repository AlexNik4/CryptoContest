import 'package:flutter/material.dart';

class CreateCompetitionScreenBloc {
  static const communityVotedCompetition = 0;
  static const creatorDecidedCompetition = 1;
  static const giveawayCompetition = 2;

  final formKey = GlobalKey<FormState>();
  final numberOfCompetitionModes = 3;

  int selectedCompetitionMode = 0;
  DateTime selectedEndDate = DateTime.now().add(Duration(days: 1));

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
        initialDate: selectedEndDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedEndDate) {
      // TODO : Alex - Use stream builder to return value
      selectedEndDate = picked;
    }
  }

  void onCreateCompetitionPressed() {
    if (formKey.currentState.validate()) {
      // TODO : Alex - Bloc.Create competition
    }
  }
}
