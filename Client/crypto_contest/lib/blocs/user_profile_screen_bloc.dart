import 'dart:async';

import 'package:crypto_contest/managers/authentication_mgr.dart';
import 'package:crypto_contest/managers/navigation_mgr.dart';
import 'package:crypto_contest/models/user_profile_model.dart';
import 'package:flutter/scheduler.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';

class UserProfileScreenBloc {
  final _authMgr = GetIt.I.get<AuthenticationMgr>();
  final _navMgr = GetIt.I.get<NavigationMgr>();
  final _subscriptions = CompositeSubscription();

  // Subjects
  final _userDetailsSubject = BehaviorSubject<UserProfileModel>.seeded(UserProfileModel());

  // Bindable view model
  Observable<UserProfileModel> get userDetails => _userDetailsSubject.stream;

  /// Constructor
  UserProfileScreenBloc() {
    _subscriptions.add(_authMgr.currentUserDetails.listen((x) => _userDetailsSubject.add(x)));

    // Verify a user is logged in. If not, schedule to navigate to the login screen
    if (!_authMgr.isLoggedIn) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        _navMgr.navigateToAuthenticationScreen().then((value) {
          if (!_authMgr.isLoggedIn) {
            // Pop screen if we still have not logged in
            _navMgr.popScreen();
          }
        });
      });
    }
  }

  /// Log off the current user
  Future<void> logOffUser() async {
    await _authMgr.signOut();
    _navMgr.popScreen();
  }

  /// Dispose
  void dispose() {
    _subscriptions.dispose();
    _userDetailsSubject.close();
  }
}
