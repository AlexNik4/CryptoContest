import 'package:crypto_contest/managers/authentication_mgr.dart';
import 'package:crypto_contest/managers/navigation_mgr.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class AuthenticationScreenBloc {
  final _authMgr = GetIt.I.get<AuthenticationMgr>();
  final _navMgr = GetIt.I.get<NavigationMgr>();

  final formKey = GlobalKey<FormState>();

  String email;
  String password;

  String validateEmailValue(String value) {
    if (value.trim().isEmpty) {
      return "Competition title required";
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
}
