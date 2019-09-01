import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

/// Manages user authentication state and user information
class AuthenticationMgr {
  final _auth = FirebaseAuth.instance;
  FirebaseUser _currentUser;

  FirebaseUser get currentUser => _currentUser;
  bool get isLoggedIn => _currentUser != null;

  /// Constructor
  AuthenticationMgr() {
    _auth.onAuthStateChanged.listen((x) => _currentUser = x);
  }

  /// Register a new user with the given username and password
  Future<MyAuthResult> createUser(String email, String password) async {
    MyAuthResult authResult = MyAuthResult();
    try {
      var firebaseResult =
          await _auth.createUserWithEmailAndPassword(email: email, password: password);
      authResult.firebaseResult = firebaseResult;
    } catch (e) {
      var platformEx = e as PlatformException;
      if (platformEx != null) {
        authResult.errorCode = platformEx.code;
        authResult.errorMessage = platformEx.message;
      }
    }

    return authResult;
  }

  /// Attempt to authenticated the user with the given email and password
  Future<MyAuthResult> authenticateUser(String email, String password) async {
    MyAuthResult authResult = MyAuthResult();
    try {
      var firebaseResult = await _auth.signInWithEmailAndPassword(email: email, password: password);
      authResult.firebaseResult = firebaseResult;
    } catch (e) {
      var platformEx = e as PlatformException;
      if (platformEx != null) {
        authResult.errorCode = platformEx.code;
        authResult.errorMessage = platformEx.message;
      }
    }

    return authResult;
  }

  /// Sign out the current user
  Future<void> signOut() {
    return _auth.signOut();
  }
}

/// Represents the authenticatio results
class MyAuthResult {
  AuthResult firebaseResult;
  String errorCode;
  String errorMessage;
}
