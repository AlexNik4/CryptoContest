import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

/// Represents an existing competion
class Competition {
  // The id of the document in the db
  String id;

  // The total prize this competition is worth
  final double prizeValue;
  static const String prizeValueKey = 'prizeValue';

  // The type of token of the prize
  final String coinSymbol;
  static const String coinSymbolKey = 'coinSymbol';

  // Create time of this competition
  DateTime createTime;
  static const String createTimeKey = 'createTime';

  // When is the comptetition closed
  final Duration duration;
  static const String durationKey = 'duration';

  // The title of the competition
  final String title;
  static const String titleKey = 'title';

  // The description of how to participate in the competition
  final String description;
  static const String descriptionKey = 'description';

  // The unique identifier of the user who created this competition
  final String creatorId;
  static const String creatorIdKey = 'creatorId';

  // The display name of the user who created this competition
  final String creatorDisplayName;
  static const String creatorDisplayNameKey = 'creatorDisplayName';

  // The number of users following this competition
  final int followerCount;
  static const String followerCountKey = 'followerCount';

  /// Constructor
  Competition(
      {@required this.prizeValue,
      @required this.coinSymbol,
      @required this.duration,
      @required this.title,
      @required this.description,
      @required this.creatorId,
      @required this.creatorDisplayName,
      this.followerCount = 0});

  Competition.fromMap(Map<String, dynamic> data, String id)
      : id = id,
        prizeValue = data[prizeValueKey],
        coinSymbol = data[coinSymbolKey],
        createTime = (data[createTimeKey] as Timestamp).toDate(),
        duration = data[durationKey],
        title = data[titleKey],
        description = data[descriptionKey],
        creatorId = data[creatorIdKey],
        creatorDisplayName = data[creatorDisplayNameKey],
        followerCount = data[followerCountKey];
}
