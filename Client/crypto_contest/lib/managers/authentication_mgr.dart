import 'package:firebase_auth/firebase_auth.dart';

/// Manages user authentication state and user information
class AuthenticationMgr {
  final _auth = FirebaseAuth.instance;
  FirebaseUser _currentUser;

  FirebaseUser get currentUser => _currentUser;

  bool get isLoggedIn => _currentUser != null;

  AuthenticationMgr() {
    _auth.onAuthStateChanged.listen((x) => _currentUser = x);
  }

  Future<FirebaseUser> createUser(String email, String password) async {
    // TODO : Alex : Check if fixed : https://github.com/flutter/plugins/pull/1937/commits/6fdc1e9b18bd168d997f6b2777bd28f2b3b00c25
    try {
      var result = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return result.user;
    } catch (e) {
      return null;
    }
  }

  Future<FirebaseUser> authenticateUser(String email, String password) async {
    // TODO : Alex : Check if fixed : https://github.com/flutter/plugins/pull/1937/commits/6fdc1e9b18bd168d997f6b2777bd28f2b3b00c25
    try {
      var result =
          await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      return result.user;
    } catch (e) {
      return null;
    }
  }

  Future<void> signOut() {
    return _auth.signOut();
  }
}
