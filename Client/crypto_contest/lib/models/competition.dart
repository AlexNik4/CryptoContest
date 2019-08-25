class Competition {
  // The total prize this competition is worth
  double tokenAmount;

  // The type of token of the prize
  String token;

  // Create time of this competition
  DateTime createTime;

  // When is the comptetition closed
  DateTime endTime;

  // The title of the competition
  String title;

  // The description of how to participate in the competition
  String description;

  // The unique identifier of the user who created this competition
  String creatorId;

  // The display name of the user who created this competition
  String creatorDisplayName;

  // The number of users following this competition
  int numOfFollowers;
}
