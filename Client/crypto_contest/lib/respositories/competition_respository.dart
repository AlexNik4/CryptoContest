import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_contest/models/competition.dart';

class CompetitionRepository {
  Competition getCompetitionDetails(String id) {
    Random random = Random();

    Competition comp = Competition();
    comp.title = "Free giveaway! Join now";
    comp.description =
        "Anyone who creates an account and comments for this competition will get an account";
    comp.createTime = Timestamp.now().toDate();
    comp.endTime = Timestamp.now().toDate().add(Duration(hours: 1));
    comp.creatorDisplayName = "Alex";
    comp.tokenAmount = random.nextInt(100).toDouble();
    comp.numOfFollowers = random.nextInt(1000);
    comp.token = "Bitcoins";

    return comp;
  }
}
