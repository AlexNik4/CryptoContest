import 'package:flutter/foundation.dart';

/// Represents an existing competion
class Competition {
  // The id of the document in the db
  String id;

  // The total prize this competition is worth
  final double prizeValue;
  static final String prizeValueKey = 'prizeValue';

  // The type of token of the prize
  final String coinSymbol;
  static final String coinSymbolKey = 'coinSymbolKey';

  // Create time of this competition
  DateTime createTime;
  static final String createTimeKey = 'createTimeKey';

  // When is the comptetition closed
  final Duration duration;
  static final String durationKey = 'duration';

  // The title of the competition
  final String title;
  static final String titleKey = 'title';

  // The description of how to participate in the competition
  final String description;
  static final String descriptionKey = 'description';

  // The unique identifier of the user who created this competition
  final String creatorId;
  static final String creatorIdKey = 'creatorId';

  // The display name of the user who created this competition
  final String creatorDisplayName;
  static final String creatorDisplayNameKey = 'creatorDisplayName';

  // The number of users following this competition
  final int followerCount;
  static final String followerCountKey = 'followerCount';

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
        createTime = data[createTimeKey],
        duration = data[durationKey],
        title = data[titleKey],
        description = data[descriptionKey],
        creatorId = data[creatorIdKey],
        creatorDisplayName = data[creatorDisplayNameKey],
        followerCount = data[followerCountKey];
}
