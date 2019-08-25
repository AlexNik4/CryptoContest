import 'package:crypto_contest/models/competition.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CompetitionItemWidget extends StatelessWidget {
  final Competition competition;

  const CompetitionItemWidget(this.competition);

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
                    Text(competition.creatorDisplayName),
                    Expanded(
                      child: SizedBox(),
                    ),
                    Text(
                      competition.tokenAmount.toString(),
                      style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 17),
                    ),
                    Text(competition.token)
                  ],
                ),
                Text(
                  competition.title,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Icon(
                        Icons.group,
                        color: Colors.blueAccent,
                        size: 19,
                      ),
                      Text(
                        competition.numOfFollowers.toString(),
                        style: TextStyle(fontSize: 16),
                      ),
                    ])
              ],
            ),
          ),
          Positioned.fill(
              child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    highlightColor: Color(0x4499ccff),
                    splashColor: Color(0x4466b3ff),
                    onTap: () => null,
                  )))
        ]),
      ),
    );
  }
}
