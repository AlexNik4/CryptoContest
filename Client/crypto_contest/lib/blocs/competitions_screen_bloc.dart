import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_contest/database_schema/competition.dart';
import 'package:crypto_contest/managers/navigation_mgr.dart';
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

    // TODO : Alex - Filter out the invalid competitions here
    _streamController.sink.add((newList));
  }

  void createNewCompetition() async {
    await GetIt.I.get<NavigationMgr>().navigateToCreateCompetitionScreen();
    loadCompetitions();
  }

  void loadCompetitions() {
    _disposable.add(_repository.getTopCompetitionsQuery().snapshots().listen(_handleSnapshot));
  }

  void dispose() {
    _disposable.dispose();
    _streamController.close();
  }
}
