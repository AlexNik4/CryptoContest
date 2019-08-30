import 'package:crypto_contest/managers/authentication_mgr.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class AuthenticationScreenBloc {
  final _authMgr = GetIt.I.get<AuthenticationMgr>();
  final formKey = GlobalKey<FormState>();

  String email;
  String password;

  void _onAuthenticationError() {
    // TODO : Alex - Display auth error to the user
  }

  void onLoginPressed() async {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      await _authMgr
          .authenticateUser(email, password)
          .catchError(_onAuthenticationError);
      // TODO : Alex - Navigate exit screen and continue with the screen that required login
    }
  }
}
