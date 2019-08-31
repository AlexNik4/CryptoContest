import 'package:crypto_contest/blocs/authentication_screen_bloc.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AuthenticationScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AuthenticationScreenState();
  }
}

/// Reperesent the authentication screen to login existin users or register new users
class _AuthenticationScreenState extends State<AuthenticationScreen> {
  final _bloc = AuthenticationScreenBloc();

  @override
  Widget build(BuildContext context) {
    const spaceBetweenFields = const SizedBox(
      height: 25,
    );

    var emailFormField = TextFormField(
      onSaved: (value) => _bloc.email = value,
      style: TextStyle(fontSize: 24),
      decoration: InputDecoration(
        labelText: "Email",
        contentPadding: new EdgeInsets.only(top: 8.0),
        icon: const Icon(Icons.email, color: Colors.black),
      ),
      validator: _bloc.validateEmailValue,
      keyboardType: TextInputType.emailAddress,
    );

    var passwordFormField = TextFormField(
      onSaved: (value) => _bloc.password = value,
      obscureText: true,
      style: TextStyle(fontSize: 24),
      decoration: InputDecoration(
        labelText: "Password",
        contentPadding: new EdgeInsets.only(top: 8.0),
        icon: const Icon(Icons.lock, color: Colors.black),
      ),
      validator: _bloc.validatePasswordValue,
      keyboardType: TextInputType.text,
    );

    var userDisplayNameFormField = TextFormField(
      onSaved: (value) => _bloc.userDisplayName = value,
      style: TextStyle(fontSize: 24),
      decoration: InputDecoration(
        labelText: "Name",
        contentPadding: new EdgeInsets.only(top: 8.0),
        icon: const Icon(Icons.person, color: Colors.black),
      ),
      validator: _bloc.validateDisplayNameValue,
      keyboardType: TextInputType.text,
    );

    var verificationCodeFormField = TextFormField(
      onSaved: (value) => _bloc.userDisplayName = value,
      style: TextStyle(fontSize: 24),
      decoration: InputDecoration(
        labelText: "Verification Code",
        contentPadding: new EdgeInsets.only(top: 8.0),
        icon: const Icon(Icons.security, color: Colors.black),
      ),
      validator: _bloc.validateVerificationCodeValue,
      keyboardType: TextInputType.number,
    );

    var frontLoginCard = Card(
      elevation: 4,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(7.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              spaceBetweenFields,
              emailFormField,
              spaceBetweenFields,
              passwordFormField,
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ButtonTheme(
                    minWidth: 100,
                    height: 42,
                    child: FlatButton(
                      onPressed: () => _bloc.flipState(),
                      child: const Text('Sign Up', style: const TextStyle(fontSize: 16)),
                    ),
                  ),
                  ButtonTheme(
                    minWidth: 100,
                    height: 42,
                    child: RaisedButton(
                      onPressed: _bloc.onLoginPressed,
                      child: const Text('LOGIN', style: const TextStyle(fontSize: 22)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );

    var backSignUpCard = Card(
      elevation: 4,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(7.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              spaceBetweenFields,
              userDisplayNameFormField,
              spaceBetweenFields,
              emailFormField,
              spaceBetweenFields,
              passwordFormField,
              spaceBetweenFields,
              verificationCodeFormField,
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ButtonTheme(
                    minWidth: 100,
                    height: 42,
                    child: FlatButton(
                      onPressed: () => _bloc.flipState(),
                      child: const Text('Sign In', style: const TextStyle(fontSize: 16)),
                    ),
                  ),
                  ButtonTheme(
                    minWidth: 100,
                    height: 42,
                    child: RaisedButton(
                      onPressed: _bloc.onLoginPressed,
                      child: const Text('Register', style: const TextStyle(fontSize: 22)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );

    return Form(
      key: _bloc.formKey,
      child: SafeArea(
        child: Scaffold(
          body: Stack(
            children: <Widget>[
              // Background
              Container(
                height: MediaQuery.of(context).size.height / 8,
                child: Center(
                  child: Text(
                    "Crypto Contest",
                    style:
                        TextStyle(fontSize: 30, color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
                decoration: new BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: new BorderRadius.only(
                        bottomLeft: const Radius.circular(40.0),
                        bottomRight: const Radius.circular(40.0))),
              ),
              // Login area
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 10.5,
                    left: 20,
                    right: 20,
                    bottom: 10),
                child: FlipCard(
                  flipOnTouch: false,
                  key: _bloc.cardKey,
                  direction: FlipDirection.HORIZONTAL,
                  front: frontLoginCard,
                  back: backSignUpCard,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
