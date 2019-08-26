import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_contest/database_schema/competition.dart';
import 'package:crypto_contest/respositories/competition_respository.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';

class CompetitionsScreenBloc {
  final CompositeSubscription _disposable = CompositeSubscription();
  final CompetitionRepository _repository = GetIt.I.get<CompetitionRepository>();
  final StreamController<List<Competition>> _streamController =
      new StreamController<List<Competition>>();

  get competitionsStream => _streamController.stream;

  void _handleSnapshot(QuerySnapshot snapshot) {
    // Dont listen to every single update from the db
    if (!snapshot.metadata.isFromCache) {
      _disposable.clear();
    }
    List<Competition> newList =
        snapshot.documents.map((doc) => Competition.fromMap(doc.data, doc.documentID)).toList();
    _streamController.sink.add((newList));
  }

  void loadCompetitions() {
    _disposable.add(_repository.getTopCompetitionsQuery().snapshots().listen(_handleSnapshot));
  }

  void createNewCompetition() {
    Competition newComp = Competition(
        title: "Free giveaway! Join now.",
        description:
            "Anyone who creates an account and comments for this competition will get an account",
        duration: Duration(days: 5),
        prizeValue: 0.5,
        creatorDisplayName: "Alex",
        creatorId: "TODO",
        coinSymbol: "BTC");

    _repository.createNewCompetition(newComp);
  }

  void dispose() {
    _disposable.dispose();
    _streamController.close();
  }
}
