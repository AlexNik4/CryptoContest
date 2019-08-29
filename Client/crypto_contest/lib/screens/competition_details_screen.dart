import 'package:crypto_contest/database_schema/competition.dart';
import 'package:flutter/material.dart';

class CompetitionDetailsScreen extends StatefulWidget {
  static const routeName = '/competitionDetails';

  _CompetitionDetailsScreenState createState() => _CompetitionDetailsScreenState();
}

class _CompetitionDetailsScreenState extends State<CompetitionDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final Competition competition = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      backgroundColor: const Color(0xffe6e6e6),
      appBar: AppBar(
        title: Text(competition.title),
      ),
    );
  }
}
