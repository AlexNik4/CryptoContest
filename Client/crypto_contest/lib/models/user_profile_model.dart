import 'package:crypto_contest/database_schema/user_profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

/// Authentication result state for the login screen
class UserProfileModel {
  final String id;
  final String userDisplayName;
  final String userEmail;
  final Color userPrimaryColor;

  // TODO : Alex - Remove these temp values
  UserProfileModel(
      {this.id = "",
      this.userDisplayName = "",
      this.userEmail = "",
      this.userPrimaryColor = Colors.blue});

  UserProfileModel.fromFirebaseUser(FirebaseUser user, {this.userPrimaryColor = Colors.blue})
      : this.id = user.uid,
        this.userDisplayName = user.displayName ?? user.email,
        this.userEmail = user.email;

  UserProfileModel.fromData(FirebaseUser user, UserProfile profile)
      : this.id = user.uid,
        this.userDisplayName = user.displayName ?? user.email,
        this.userEmail = user.email,
        this.userPrimaryColor = profile.primaryColor;
}
