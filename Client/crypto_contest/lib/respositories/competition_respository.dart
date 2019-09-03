import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_contest/database_schema/competition.dart';

/// Manages the creation, update and retrieval of competitions
class CompetitionRepository {
  Firestore _db = Firestore.instance;

  /// Get the top competitions query
  Query getTopCompetitionsQuery() {
    return _db.collection('competitions').limit(30).orderBy(Competition.createTimeKey);
  }

  /// Create the new given competition
  void createNewCompetition(Competition newComp) {
    _db.collection('competitions').add(newComp.toMap());
  }
}
