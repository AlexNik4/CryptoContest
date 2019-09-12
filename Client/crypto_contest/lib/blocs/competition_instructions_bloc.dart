import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_contest/database_schema/competition.dart';
import 'package:crypto_contest/database_schema/competition_details.dart';
import 'package:crypto_contest/managers/authentication_mgr.dart';
import 'package:crypto_contest/managers/navigation_mgr.dart';
import 'package:crypto_contest/respositories/competition_respository.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';

/// Handles any updates to the instructions of a competition
class CompetitionInstructionsBloc {
  final _authMgr = GetIt.I.get<AuthenticationMgr>();
  final _repository = GetIt.I.get<CompetitionRepository>();
  final Competition _competition;

  final _disposables = CompositeSubscription();

  // Subjects
  final _detailsSubject = BehaviorSubject<CompetitionDetails>.seeded(null);
  final _competitionCreatorSubject = BehaviorSubject<bool>.seeded(false);

  // Bindable view model
  ValueObservable<CompetitionDetails> get competitionDetails => _detailsSubject.stream;
  ValueObservable<bool> get isCompetitionCreator => _competitionCreatorSubject.stream;

  void _handleSnapshot(QuerySnapshot snapshot) {
    List<CompetitionDetails> details = snapshot.documents
        .map((doc) => CompetitionDetails.fromMap(doc.data, doc.documentID))
        .toList();

    if (details.length > 0) {
      _detailsSubject.add(details.first);

      if (_authMgr.currentUserDetails.value.id == _competition.creatorId) {
        _competitionCreatorSubject.add(true);
      }
    }
  }

  /// Constructor
  CompetitionInstructionsBloc(this._competition) {
    _disposables.add(
        _repository.getCompetitionDetails(_competition.id).snapshots().listen(_handleSnapshot));
  }

  void addInstructionsUpdate(String update) async {
    // TODO : Alex - Show indicator and other reactive UI updates
    if (_detailsSubject.hasValue) {
      List<String> instructionUpdates = _detailsSubject.value.creatorUpdates;
      instructionUpdates.add(update);
      await _repository.setCompetitionInstructionUpdates(_competition, instructionUpdates);
    }
    GetIt.I.get<NavigationMgr>().popScreen();
  }

  /// Dispose
  void dispose() {
    _disposables.dispose();
  }
}
