import 'package:crypto_contest/helpers/enums.dart';

class CreateCompetitionViewModel {
  String title;
  String description;
  CompetitionTypes selectedCompetitionMode = CompetitionTypes.communityVoted;
  DateTime selectedEndDate = DateTime.now().add(Duration(days: 1));
  String prizeValue;
  String coinSymbol;
}
