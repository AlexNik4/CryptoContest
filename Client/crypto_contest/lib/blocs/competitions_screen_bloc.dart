import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_contest/models/competition.dart';
import 'package:crypto_contest/respositories/competition_respository.dart';
import 'package:get_it/get_it.dart';

class CompetitionsScreenBloc {
  final CompetitionRepository _repository = GetIt.I.get<CompetitionRepository>();
  final StreamController<List<Competition>> _streamController =
      new StreamController<List<Competition>>();

  get competitionsStream => _streamController.stream;

  CompetitionsScreenBloc() {
    _repository.competitionsStream.listen((x) => _streamController.sink.add(x));
  }

  void createNewCompetition() {
    final Competition newComp = Competition();
    newComp.title = "Free giveaway! Join now";
    newComp.description =
        "Anyone who creates an account and comments for this competition will get an account";
    newComp.createTime = Timestamp.now().toDate();
    newComp.endTime = Timestamp.now().toDate().add(Duration(hours: 1));
    newComp.creatorDisplayName = "Alex";
    newComp.tokenAmount = 100;
    newComp.numOfFollowers = 888;
    newComp.token = "Bitcoins";

    _repository.createNewCompetition(newComp);
  }

  void dispose() {
    _streamController.close();
  }
}
