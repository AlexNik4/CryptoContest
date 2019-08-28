class CreateCompetitionViewModel {
  String title;
  String description;
  int selectedCompetitionMode = 0;
  DateTime selectedEndDate = DateTime.now().add(Duration(days: 1));
  String prizeValue;
  String coinSymbol;
}
