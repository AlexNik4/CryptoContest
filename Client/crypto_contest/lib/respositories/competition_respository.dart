import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_contest/database_schema/competition.dart';

class CompetitionRepository {
  Firestore _db = Firestore.instance;

  Query getTopCompetitionsQuery() {
    return Firestore.instance.collection('competitions').limit(30);
  }

  void createNewCompetition(Competition newComp) {
    // TODO : Alex - Implement
  }
}
