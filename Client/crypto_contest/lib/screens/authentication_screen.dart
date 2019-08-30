import 'package:crypto_contest/blocs/authentication_screen_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AuthenticationScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AuthenticationScreenState();
  }
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  final _bloc = AuthenticationScreenBloc();

  @override
  Widget build(BuildContext context) {
    var emailFormField = TextFormField(
      onSaved: (value) => _bloc.email = value,
      decoration: InputDecoration(
        labelText: "Email",
        icon: const Icon(Icons.email, color: Colors.black),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
      validator: _bloc.validateEmailValue,
      keyboardType: TextInputType.emailAddress,
      style: const TextStyle(
        fontFamily: "Poppins",
      ),
    );

    var textFormField = TextFormField(
      onSaved: (value) => _bloc.password = value,
      obscureText: true,
      decoration: InputDecoration(
        labelText: "Password",
        icon: const Icon(Icons.lock, color: Colors.black),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
      validator: _bloc.validatePasswordValue,
      keyboardType: TextInputType.text,
      style: const TextStyle(
        fontFamily: "Poppins",
      ),
    );

    return Form(
      key: _bloc.formKey,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: const Color(0xffff8c1a),
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
                        style: TextStyle(fontSize: 28),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      // Email field
                      emailFormField,
                      const SizedBox(
                        height: 25,
                      ),
                      // Password field
                      textFormField,
                      const SizedBox(
                        height: 20,
                      ),
                      ButtonTheme(
                        minWidth: 100,
                        height: 42,
                        child: RaisedButton(
                          onPressed: _bloc.onLoginPressed,
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
