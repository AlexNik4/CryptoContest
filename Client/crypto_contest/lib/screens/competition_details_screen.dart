import 'package:crypto_contest/database_schema/competition.dart';
import 'package:flutter/material.dart';

/// Displays the details for a single competition
class CompetitionDetailsScreen extends StatelessWidget {
  final Competition _competition;

  CompetitionDetailsScreen(this._competition);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_competition.title),
      ),
      body: Hero(tag: _competition.id, child: Container()),
    );
  }
}
