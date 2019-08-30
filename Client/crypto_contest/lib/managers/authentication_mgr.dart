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

  Future<AuthResult> createUser(String email, String password) async {
    return FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<AuthResult> authenticateUser(String email, String password) async {
    return FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
}
