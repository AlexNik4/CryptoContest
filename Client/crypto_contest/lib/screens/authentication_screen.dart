import 'package:crypto_contest/blocs/authentication_screen_bloc.dart';
import 'package:crypto_contest/helpers/authentication_validator.dart';
import 'package:crypto_contest/widgets/shake_animation_widget.dart';
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
class _AuthenticationScreenState extends State<AuthenticationScreen>
    with SingleTickerProviderStateMixin {
  final _validator = AuthenticationValidator();
  AuthenticationScreenBloc _bloc;

  @override
  void initState() {
    _bloc = AuthenticationScreenBloc();
    super.initState();
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

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
        contentPadding: new EdgeInsets.symmetric(vertical: 4),
        icon: const Icon(Icons.email, color: Colors.black),
      ),
      validator: _validator.validateEmailValue,
      keyboardType: TextInputType.emailAddress,
    );

    var passwordFormField = TextFormField(
      onSaved: (value) => _bloc.password = value,
      obscureText: true,
      style: TextStyle(fontSize: 24),
      decoration: InputDecoration(
        labelText: "Password",
        contentPadding: new EdgeInsets.symmetric(vertical: 4),
        icon: const Icon(Icons.lock, color: Colors.black),
      ),
      validator: _validator.validatePasswordValue,
      keyboardType: TextInputType.text,
    );

    var userDisplayNameFormField = TextFormField(
      onSaved: (value) => _bloc.userDisplayName = value,
      style: TextStyle(fontSize: 24),
      decoration: InputDecoration(
        labelText: "Name",
        contentPadding: new EdgeInsets.symmetric(vertical: 4),
        icon: const Icon(Icons.person, color: Colors.black),
      ),
      validator: _validator.validateDisplayNameValue,
      keyboardType: TextInputType.text,
    );

    var progressAndResult = StreamBuilder<AuthResultState>(
      stream: _bloc.authResultState,
      builder: (context, snapshot) {
        return Stack(
          alignment: AlignmentDirectional.center,
          children: <Widget>[
            Opacity(
              opacity: snapshot.data.isProgressBarVisible ? 1.0 : 0.0,
              child: CircularProgressIndicator(),
            ),
            Text(
              snapshot.data.errorMessage,
              style: TextStyle(color: Colors.red, fontSize: 16),
            ),
          ],
        );
      },
    );

    var frontLoginCard = Card(
      elevation: 4,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(7.0),
        child: Form(
          key: _bloc.loginFormKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                spaceBetweenFields,
                emailFormField,
                spaceBetweenFields,
                passwordFormField,
                const SizedBox(
                  height: 15,
                ),
                progressAndResult,
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ButtonTheme(
                      minWidth: 100,
                      height: 42,
                      child: FlatButton(
                        onPressed: _bloc.flipState,
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
      ),
    );

    var backSignUpCard = Card(
      elevation: 4,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(7.0),
        child: Form(
          key: _bloc.singUpFormKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                userDisplayNameFormField,
                spaceBetweenFields,
                emailFormField,
                spaceBetweenFields,
                passwordFormField,
                const SizedBox(
                  height: 15,
                ),
                progressAndResult,
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ButtonTheme(
                      minWidth: 100,
                      height: 42,
                      child: FlatButton(
                        onPressed: _bloc.flipState,
                        child: const Text('Sign In', style: const TextStyle(fontSize: 16)),
                      ),
                    ),
                    ButtonTheme(
                      minWidth: 100,
                      height: 42,
                      child: RaisedButton(
                        onPressed: _bloc.onRegisterPressed,
                        child: const Text('Register', style: const TextStyle(fontSize: 22)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffe6e6e6),
        body: Stack(
          children: <Widget>[
            // Background
            Container(
              height: MediaQuery.of(context).size.height / 8,
              child: Center(
                child: Text(
                  "Crypto Contest",
                  style: TextStyle(fontSize: 30, color: Colors.black, fontWeight: FontWeight.bold),
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
                  top: MediaQuery.of(context).size.height / 10.5, left: 20, right: 20, bottom: 10),
              child: ShakeAnimationWidget(
                key: _bloc.shakeKey,
                child: FlipCard(
                  flipOnTouch: false,
                  key: _bloc.cardKey,
                  direction: FlipDirection.HORIZONTAL,
                  front: frontLoginCard,
                  back: backSignUpCard,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
