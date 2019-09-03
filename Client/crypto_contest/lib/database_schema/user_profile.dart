import 'package:flutter/material.dart';

/// Represents an existing competion
class UserProfile {
  // The id of the document in the db
  String id;

  // The total prize this competition is worth
  final Color primaryColor;
  static const String primaryColorKey = 'primaryColor';

  /// Constructor
  UserProfile({
    this.primaryColor = Colors.blue,
  });

  /// Constructor
  UserProfile.fromMap(Map<String, dynamic> data, String id)
      : id = id,
        primaryColor = data[primaryColorKey];

  Map<String, dynamic> toMap() => {
        primaryColorKey: primaryColor,
      };
}
