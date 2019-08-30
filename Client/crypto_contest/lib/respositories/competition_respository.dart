import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_contest/database_schema/competition.dart';

class CompetitionRepository {
  Firestore _db = Firestore.instance;

  Query getTopCompetitionsQuery() {
    return _db
        .collection('competitions')
        .limit(30)
        .orderBy(Competition.createTimeKey);
  }

  void createNewCompetition(Competition newComp) {
    // TODO : Alex - Use the Future properly
    _db.collection('competitions').add(newComp.toMap());
  }
}
