import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_contest/database_schema/competition.dart';
import 'package:crypto_contest/helpers/database_names.dart';

/// Manages the creation, update and retrieval of competitions
class CompetitionRepository {
  Firestore _db = Firestore.instance;

  /// Get the top competitions query
  Query getTopCompetitionsQuery() {
    return _db
        .collection(DbNames.competitionsCollection)
        .limit(30)
        .orderBy(Competition.createTimeKey);
  }

  /// Get the details about a specific collection
  Query getCompetitionDetails(String competitionId) {
    return _db
        .collection(
            "${DbNames.competitionsCollection}/$competitionId/${DbNames.competitionDetailsCollection}")
        .limit(1);
  }

  /// Create the new given competition
  void createNewCompetition(Competition newComp) {
    _db.collection(DbNames.competitionsCollection).add(newComp.toMap());
  }
}
