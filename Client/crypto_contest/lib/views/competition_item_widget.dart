import 'package:crypto_contest/database_schema/competition.dart';
import 'package:crypto_contest/managers/navigation_mgr.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';

class CompetitionItemWidget extends StatelessWidget {
  final Competition _competition;

  const CompetitionItemWidget(this._competition);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Card(
        child: Stack(children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(_competition.creatorDisplayName),
                    Expanded(
                      child: const SizedBox(),
                    ),
                    Text(
                      _competition.prizeValue.toString(),
                      style: const TextStyle(
                          color: Colors.green, fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                    Text(_competition.coinSymbol)
                  ],
                ),
                Text(
                  _competition.title,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
                  const Icon(
                    Icons.group,
                    color: Colors.blueAccent,
                    size: 19,
                  ),
                  Text(
                    _competition.followerCount.toString(),
                    style: const TextStyle(fontSize: 16),
                  ),
                ])
              ],
            ),
          ),
          Positioned.fill(
              child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    highlightColor: const Color(0x4499ccff),
                    splashColor: const Color(0x4466b3ff),
                    onTap: () => GetIt.I
                        .get<NavigationMgr>()
                        .navigateToCompetitionDetailsScreen(_competition),
                  )))
        ]),
      ),
    );
  }
}
