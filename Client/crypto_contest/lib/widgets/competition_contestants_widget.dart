import 'package:crypto_contest/database_schema/competition.dart';
import 'package:flutter/material.dart';

class CompetitionContestantsWidget extends StatefulWidget {
  final Competition competition;

  /// Constructor
  CompetitionContestantsWidget(this.competition, {Key key}) : super(key: key);

  @override
  _CompetitionContestantsWidgetState createState() => _CompetitionContestantsWidgetState();
}

class _CompetitionContestantsWidgetState extends State<CompetitionContestantsWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
    );
  }
}
