import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationManager {
  FirebaseUser _user;

  FirebaseUser get current_user => _user;

  AuthenticationManager() {
    FirebaseAuth.instance.onAuthStateChanged.listen((x) => _user = x);
  }

  void createUser() async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: 'alexn8@hotmail.com',
      password: 'a password',
    );
  }

  void authenticate() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: 'an email',
      password: 'a password',
    );
  }
}
