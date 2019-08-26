import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_contest/models/competition.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class CompetitionRepository {
  BehaviorSubject<List<Competition>> _subject = BehaviorSubject.seeded(null);
  List<Competition> _competitions = List<Competition>();

  Observable get competitionsStream => _subject.stream;

  CompetitionRepository() {
    Random random = Random();

    for (int i = 0; i < 20; i++) {
      Competition comp = Competition();
      comp.title = "Free giveaway! Join now";
      comp.description =
          "Anyone who creates an account and comments for this competition will get an account";
      comp.createTime = Timestamp.now().toDate();
      comp.endTime = Timestamp.now().toDate().add(Duration(hours: 1));
      comp.creatorDisplayName = "Alex";
      comp.tokenAmount = random.nextInt(100).toDouble();
      comp.numOfFollowers = random.nextInt(1000);
      comp.token = "Bitcoins";
      _competitions.add(comp);
    }

    _subject.add(_competitions);
  }

  void createNewCompetition(Competition newComp) {
    _competitions.add(newComp);
    _subject.add(_competitions);
  }
}
