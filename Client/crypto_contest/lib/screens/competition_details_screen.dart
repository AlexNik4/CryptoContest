import 'package:crypto_contest/database_schema/competition.dart';
import 'package:flutter/material.dart';

class CompetitionDetailsScreen extends StatefulWidget {
  _CompetitionDetailsScreenState createState() => _CompetitionDetailsScreenState();
}

class _CompetitionDetailsScreenState extends State<CompetitionDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final Competition competition = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(competition.title),
      ),
    );
  }
}
