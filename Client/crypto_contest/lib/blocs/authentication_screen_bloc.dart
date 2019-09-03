import 'package:crypto_contest/managers/authentication_mgr.dart';
import 'package:crypto_contest/managers/navigation_mgr.dart';
import 'package:crypto_contest/widgets/shake_animation_widget.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';

/// Business logic for the authentication screen
class AuthenticationScreenBloc {
  // Managers
  final _authMgr = GetIt.I.get<AuthenticationMgr>();
  final _navMgr = GetIt.I.get<NavigationMgr>();

  // Keys
  final loginFormKey = GlobalKey<FormState>();
  final singUpFormKey = GlobalKey<FormState>();
  final cardKey = GlobalKey<FlipCardState>();
  final shakeKey = GlobalKey<ShakeAnimationWidgetState>();

  // Subjects
  final _authenticationResultSubject = BehaviorSubject<AuthResultState>.seeded(AuthResultState());

  // Bindable view model
  String email;
  String password;
  String userDisplayName;
  ValueObservable<AuthResultState> get authResultState => _authenticationResultSubject.stream;

  // Public interface
  /// Flip between the registration and login card
  void flipState() {
    _authenticationResultSubject.add(AuthResultState());
    loginFormKey.currentState.reset();
    singUpFormKey.currentState.reset();
    cardKey.currentState.toggleCard();
  }

  /// Handle the login action
  void onLoginPressed() async {
    if (loginFormKey.currentState.validate()) {
      loginFormKey.currentState.save();

      _authenticationResultSubject
          .add(AuthResultState(isProgressBarVisible: true, errorMessage: ""));
      MyAuthResult authResult = await _authMgr.authenticateUser(email, password);
      if (authResult.firebaseResult != null && authResult.firebaseResult.user != null) {
        // Succesfully retrieve a user
        _navMgr.popScreen();
        return;
      }

      _handleAuthResult(authResult);
    }
  }

  /// Handle the registration of a new user
  void onRegisterPressed() async {
    if (singUpFormKey.currentState.validate()) {
      singUpFormKey.currentState.save();

      _authenticationResultSubject
          .add(AuthResultState(isProgressBarVisible: true, errorMessage: ""));
      MyAuthResult authResult = await _authMgr.createUser(email, password);
      if (authResult.firebaseResult != null && authResult.firebaseResult.user != null) {
        // TODO : Alex - Now we should verify email
        await _authMgr.updateUserInformation(userDisplayName);
        _navMgr.popScreen();
        return;
      }

      _handleAuthResult(authResult);
    }
  }

  /// Dispose
  void dispose() {
    _authenticationResultSubject.close();
  }

  // Private methods
  void _handleAuthResult(MyAuthResult authResult) {
    switch (authResult.errorCode) {
      case 'ERROR_INVALID_CREDENTIAL':
      case 'ERROR_WRONG_PASSWORD':
      case 'ERROR_USER_NOT_FOUND':
        authResult.errorMessage = "Invalid credentials";
        shakeKey.currentState.startAnimation();
        break;
    }

    if (authResult.errorMessage == null) {
      authResult.errorMessage = "Unknown error";
    }

    _authenticationResultSubject
        .add(AuthResultState(isProgressBarVisible: false, errorMessage: authResult.errorMessage));
  }
}

/// Authentication result state for the login screen
class AuthResultState {
  final String errorMessage;
  final bool isProgressBarVisible;

  AuthResultState({this.errorMessage = "", this.isProgressBarVisible = false});
}
