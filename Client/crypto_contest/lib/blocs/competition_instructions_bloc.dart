import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_contest/database_schema/competition_details.dart';
import 'package:crypto_contest/respositories/competition_respository.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';

/// Handles any updates to the instructions of a competition
class CompetitionInstructionsBloc {
  final _repository = GetIt.I.get<CompetitionRepository>();
  final _competitionId;

  final _disposables = CompositeSubscription();

  // Subjects
  final _detailsSubject = BehaviorSubject<CompetitionDetails>.seeded(null);

  // Bindable view model
  ValueObservable<CompetitionDetails> get competitionDetails => _detailsSubject.stream;

  void _handleSnapshot(QuerySnapshot snapshot) {
    List<CompetitionDetails> details = snapshot.documents
        .map((doc) => CompetitionDetails.fromMap(doc.data, doc.documentID))
        .toList();

    _detailsSubject.add(details.first);
  }

  /// Constructor
  CompetitionInstructionsBloc(this._competitionId) {
    _disposables
        .add(_repository.getCompetitionDetails(_competitionId).snapshots().listen(_handleSnapshot));
  }

  /// Dispose
  void dispose() {
    _disposables.dispose();
  }
}
