import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:rxdart/rxdart.dart';

/// Manages user authentication state and user information
class AuthenticationMgr {
  final _auth = FirebaseAuth.instance;
  final _subscriptions = CompositeSubscription();
  FirebaseUser _currentUser;

  // Subjects
  // TODO : Alex - Use my own model here!! Check for nulls since the Firebase user is null on init
  final _currentUserSubject = BehaviorSubject<FirebaseUser>.seeded(null);

  // Public details
  Observable<FirebaseUser> get currentUserDetails => _currentUserSubject.stream;
  FirebaseUser get currentUser => _currentUser;
  bool get isLoggedIn => _currentUser != null;

  // TODO : Alex - Only use the observable
  void _onUserUpdated(FirebaseUser user) {
    _currentUser = user;
    _currentUserSubject.add(user);
  }

  /// Constructor
  AuthenticationMgr() {
    _subscriptions.add(_auth.onAuthStateChanged.listen(_onUserUpdated));
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

  Future<void> updateUserInformation(String displayName) async {
    if (_currentUser != null) {
      UserUpdateInfo updateInfo = UserUpdateInfo();
      updateInfo.displayName = displayName;
      try {
        await _currentUser.updateProfile(updateInfo);
        _currentUser.reload();
        // https://github.com/flutter/flutter/issues/20390
        _currentUser = await _auth.currentUser();
      } catch (e) {
        print(e.toString());
      }
    }
  }

  /// Sign out the current user
  Future<void> signOut() {
    return _auth.signOut();
  }

  /// Dipose
  void dispose() {
    _subscriptions.dispose();
  }
}

/// Represents the authenticatio results
class MyAuthResult {
  AuthResult firebaseResult;
  String errorCode;
  String errorMessage;
}
