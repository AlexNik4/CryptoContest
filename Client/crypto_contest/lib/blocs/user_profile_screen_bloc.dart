import 'dart:async';

import 'package:crypto_contest/managers/authentication_mgr.dart';
import 'package:crypto_contest/managers/navigation_mgr.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';

class UserProfileScreenBloc {
  final _authMgr = GetIt.I.get<AuthenticationMgr>();
  final _navMgr = GetIt.I.get<NavigationMgr>();
  final _subscriptions = CompositeSubscription();

  // Subjects
  final _userDetailsSubject = BehaviorSubject<UserProfileDetails>.seeded(UserProfileDetails());

  // Bindable view model
  Observable<UserProfileDetails> get userDetails => _userDetailsSubject.stream;

  /// Constructor
  UserProfileScreenBloc() {
    _subscriptions.add(_authMgr.currentUserDetails
        .map((x) => UserProfileDetails.fromFirebaseUser(x))
        .listen((x) => _userDetailsSubject.add(x)));

    // Verify a user is logged in. If not, schedule to navigate to the login screen
    if (!_authMgr.isLoggedIn) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        _navMgr.navigateToAuthenticationScreen();
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

/// Authentication result state for the login screen
class UserProfileDetails {
  final String userDisplayName;
  final String userEmail;
  final Color userPrimaryColor;

  // TODO : Alex - Remove these temp values
  UserProfileDetails(
      {this.userDisplayName = "", this.userEmail = "", this.userPrimaryColor = Colors.blue});

  UserProfileDetails.fromFirebaseUser(FirebaseUser user, {this.userPrimaryColor = Colors.blue})
      : this.userDisplayName = user.displayName ?? "",
        this.userEmail = user.email;
}
