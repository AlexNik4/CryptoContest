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
