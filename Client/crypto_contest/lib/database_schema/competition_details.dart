import 'package:flutter/foundation.dart';

/// Represents an existing competion
class CompetitionDetails {
  // The id of the document in the db
  String id;

  // The description of how to participate in the competition
  final String description;
  static const String descriptionKey = 'description';

  // The unique identifier of the user who created this competition
  final List<String> creatorUpdates;
  static const String creatorUpdatesKey = 'creatorUpdates';

  /// Constructor
  CompetitionDetails({@required this.description, @required this.creatorUpdates});

  /// Constructor
  CompetitionDetails.fromMap(Map<String, dynamic> data, String id)
      : id = id,
        description = data[descriptionKey],
        creatorUpdates = data.containsKey(creatorUpdatesKey)
            ? List.from(data[creatorUpdatesKey])
            : List<String>();
}
