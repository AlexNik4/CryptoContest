import 'package:crypto_contest/managers/authentication_mgr.dart';
import 'package:crypto_contest/managers/navigation_mgr.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class AuthenticationScreenBloc {
  final _authMgr = GetIt.I.get<AuthenticationMgr>();
  final _navMgr = GetIt.I.get<NavigationMgr>();

  final formKey = GlobalKey<FormState>();
  final cardKey = GlobalKey<FlipCardState>();

  String email;
  String password;
  String userDisplayName;
  String verificationCode;

  String validateEmailValue(String value) {
    if (value.trim().isEmpty) {
      return "Email required";
    }
    if (!value.contains("@")) {
      return "Invalid email address";
    }
    return null;
  }

  String validatePasswordValue(String value) {
    if (value.length < 8) {
      return "Minimum 8 characters are required";
    }
    return null;
  }

  String validateDisplayNameValue(String value) {
    if (value.isEmpty) {
      return "Name required";
    }
    return null;
  }

  void flipState() {
    formKey.currentState.reset();
    cardKey.currentState.toggleCard();
  }

  String validateVerificationCodeValue(String value) {
    if (value.isEmpty) {
      return "Check email for verification code";
    }
    return null;
  }

  void onLoginPressed() async {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      var user = await _authMgr.authenticateUser(email, password);
      if (user != null) {
        _navMgr.popScreen();
        return;
      }
    }
  }

  void onRegisterPressed() async {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      var user = await _authMgr.createUser(email, password);
      if (user != null) {
        _navMgr.popScreen();
        return;
      }
    }
  }
}
