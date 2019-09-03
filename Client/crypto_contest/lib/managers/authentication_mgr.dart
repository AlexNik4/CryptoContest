import 'package:crypto_contest/models/user_profile_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:rxdart/rxdart.dart';

/// Manages user authentication state and user information
class AuthenticationMgr {
  final _auth = FirebaseAuth.instance;
  final _subscriptions = CompositeSubscription();
  FirebaseUser _currentFirebaseUser;

  // Subjects
  final _currentUserSubject = BehaviorSubject<UserProfileModel>.seeded(UserProfileModel());

  // Public details
  ValueObservable<UserProfileModel> get currentUserDetails => _currentUserSubject.stream;
  bool get isLoggedIn => _currentFirebaseUser != null;

  /// Constructor
  AuthenticationMgr() {
    _subscriptions.add(_auth.onAuthStateChanged.listen((newUser) {
      _setCurentUser(newUser);
    }));
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
    if (_currentFirebaseUser != null) {
      UserUpdateInfo updateInfo = UserUpdateInfo();
      updateInfo.displayName = displayName;
      try {
        await _currentFirebaseUser.updateProfile(updateInfo);
        _currentFirebaseUser.reload();
        // https://github.com/flutter/flutter/issues/20390
        _setCurentUser(await _auth.currentUser());
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

  void _setCurentUser(FirebaseUser user) {
    _currentFirebaseUser = user;
    if (user == null) {
      _currentUserSubject.add(UserProfileModel());
    } else {
      _currentUserSubject.add(UserProfileModel.fromFirebaseUser(user));
    }
  }
}

/// Represents the authenticatio results
class MyAuthResult {
  AuthResult firebaseResult;
  String errorCode;
  String errorMessage;
}
