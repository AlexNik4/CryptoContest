import 'package:crypto_contest/managers/authentication_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AuthenticationScreen extends StatefulWidget {
  AuthenticationScreen({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _AuthenticationScreenState();
  }
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  final _formKey = GlobalKey<FormState>();
  final AuthenticationManager _authMgr = new AuthenticationManager();

  void _onLoginPressed() {
    if (_formKey.currentState.validate()) {
      if (_authMgr.currentUser == null) {
        _authMgr.createUser();
      } else {
        print(_authMgr.currentUser);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: SizedBox(),
                ),
                Expanded(
                  flex: 15,
                  child: Column(
                    children: <Widget>[
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Crypto Contest",
                        style: TextStyle(fontSize: 28, color: Colors.black),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: "Email",
                          icon: const Icon(Icons.email, color: Colors.blueAccent),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        validator: (val) {
                          if (val.trim().length == 0) {
                            return "Email cannot be empty";
                          } else {
                            return null;
                          }
                        },
                        keyboardType: TextInputType.emailAddress,
                        style: const TextStyle(
                          fontFamily: "Poppins",
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: "Password",
                          icon: const Icon(Icons.lock, color: Colors.blueAccent),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        validator: (val) {
                          if (val.length == 0) {
                            return "Password cannot be empty";
                          } else {
                            return null;
                          }
                        },
                        keyboardType: TextInputType.text,
                        style: const TextStyle(
                          fontFamily: "Poppins",
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ButtonTheme(
                        minWidth: 100,
                        height: 42,
                        child: RaisedButton(
                          splashColor: Colors.blueGrey,
                          color: Colors.blue,
                          onPressed: _onLoginPressed,
                          child: const Text('Login', style: const TextStyle(fontSize: 22)),
                        ),
                      ),
                    ],
                  ),
                ),
                const Expanded(
                  flex: 2,
                  child: const SizedBox(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
