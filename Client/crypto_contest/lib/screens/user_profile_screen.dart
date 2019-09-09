import 'package:crypto_contest/blocs/user_profile_screen_bloc.dart';
import 'package:crypto_contest/models/user_profile_model.dart';
import 'package:flutter/material.dart';

class UserProfileScreen extends StatefulWidget {
  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final title = "Profile";
  UserProfileScreenBloc _bloc;

  @override
  void initState() {
    _bloc = UserProfileScreenBloc();
    super.initState();
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: StreamBuilder<UserProfileModel>(
          stream: _bloc.userDetails,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return Scaffold(
              body: SingleChildScrollView(
                child: Stack(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Container(
                          width: double.infinity,
                          color: snapshot.data.userPrimaryColor,
                          child: Column(
                            children: <Widget>[
                              const SizedBox(
                                height: 40,
                              ),
                              Icon(
                                Icons.person_pin,
                                size: 100,
                              ),
                              Text(
                                snapshot.data.userDisplayName,
                                style: TextStyle(color: Colors.black, fontSize: 24),
                              ),
                              Text(
                                snapshot.data.userEmail,
                                style: TextStyle(color: const Color(0xff4d4d4d), fontSize: 18),
                              ),
                              TextFormField(),
                            ],
                          ),
                        ),
                        Container(
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: RaisedButton(
                                child: const Text('LOG OFF', style: const TextStyle(fontSize: 22)),
                                color: snapshot.data.userPrimaryColor,
                                onPressed: _bloc.logOffUser,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SafeArea(
                        child: BackButton(
                      color: Colors.black,
                    )),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
