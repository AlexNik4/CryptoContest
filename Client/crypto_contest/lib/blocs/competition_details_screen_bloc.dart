import 'package:crypto_contest/database_schema/competition.dart';
import 'package:crypto_contest/managers/authentication_mgr.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';

/// The business logic for the competition details screen
class CompetitionDetailsScreenBloc {
  final _authMgr = GetIt.I.get<AuthenticationMgr>();
  final Competition _competition;

  // Subjects
  final _competitionCreatorSubject = BehaviorSubject<bool>.seeded(false);

  // Bindable view model
  ValueObservable<bool> get isCompetitionCreator => _competitionCreatorSubject.stream;

  CompetitionDetailsScreenBloc(this._competition) {
    // TODO : Reload the latest details, but do not immediately load all the contestants
    if (_authMgr.currentUserDetails.value.id == _competition.creatorId) {
      _competitionCreatorSubject.add(true);
    }
  }

  void enterCompetition() {
    // TODO : Alex - Verify logged in
  }

  void updateCompetition() {
    // TODO : Alex - Should be logged in just display a popup to enter an update.
  }

  void dispose() {}
}
