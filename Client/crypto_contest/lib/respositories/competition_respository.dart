import 'dart:math';

import 'package:crypto_contest/database_schema/competition.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class CompetitionRepository {
  BehaviorSubject<List<Competition>> _subject = BehaviorSubject.seeded(null);
  List<Competition> _competitions = List<Competition>();

  Observable get competitionsStream => _subject.stream;

  CompetitionRepository() {
    Random random = Random();

    for (int i = 0; i < 20; i++) {
      Competition comp = Competition(
          title: "Free giveaway! Join now.",
          description:
              "Anyone who creates an account and comments for this competition will get an account",
          duration: Duration(days: 5),
          prizeValue: random.nextInt(100).toDouble(),
          creatorDisplayName: "Alex",
          creatorId: "TODO",
          coinSymbol: "BTC");
      _competitions.add(comp);
    }

    _subject.add(_competitions);
  }

  void createNewCompetition(Competition newComp) {
    _competitions.add(newComp);
    _subject.add(_competitions);
  }
}
