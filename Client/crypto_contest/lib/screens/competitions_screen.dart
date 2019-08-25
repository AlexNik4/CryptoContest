import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_contest/models/competition.dart';
import 'package:crypto_contest/respositories/competition_respository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CompetitionsScreen extends StatefulWidget {
  @override
  _CompetitionsScreenState createState() => _CompetitionsScreenState();
}

class _CompetitionsScreenState extends State<CompetitionsScreen> {
  final CompetitionRepository repository = CompetitionRepository();
  List<Competition> competitions = List<Competition>();

  @override
  Widget build(BuildContext context) {
    final title = 'Competitions';

    final Competition newComp = Competition();
    newComp.title = "Free giveaway! Join now";
    newComp.description =
        "Anyone who creates an account and comments for this competition will get an account";
    newComp.createTime = Timestamp.now().toDate();
    newComp.endTime = Timestamp.now().toDate().add(Duration(hours: 1));
    newComp.creatorDisplayName = "Alex";
    newComp.tokenAmount = 100;
    newComp.numOfFollowers = 888;
    newComp.token = "Bitcoins";

    competitions = repository.getAllCompetitions();

    return MaterialApp(
      title: title,
      home: Scaffold(
          appBar: AppBar(
            title: Text(title),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => repository.createNewCompetition(newComp),
            tooltip: 'Increment',
            child: Icon(Icons.add),
          ), // T
          body: GridView.builder(
            itemBuilder: (context, position) {
              Competition comp = competitions[position];

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
                              Text(comp.creatorDisplayName),
                              Expanded(
                                child: SizedBox(),
                              ),
                              Text(
                                comp.tokenAmount.toString(),
                                style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17),
                              ),
                              Text(comp.token)
                            ],
                          ),
                          Text(
                            comp.title,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
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
                                  comp.numOfFollowers.toString(),
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
            },
            itemCount: competitions.length,
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          )),
    );
  }
}
