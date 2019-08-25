import 'package:crypto_contest/models/competition.dart';
import 'package:crypto_contest/respositories/competition_respository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CompetitionsScreen extends StatefulWidget {
  @override
  _CompetitionsScreenState createState() => _CompetitionsScreenState();
}

class _CompetitionsScreenState extends State<CompetitionsScreen> {
  List<Competition> competitions = List<Competition>();

  @override
  Widget build(BuildContext context) {
    final title = 'Competitions';

    competitions.clear();
    CompetitionRepository repository = CompetitionRepository();
    for (int i = 0; i < 20; i++) {
      competitions.add(repository.getCompetitionDetails("id: $i"));
    }

    return MaterialApp(
      title: title,
      home: Scaffold(
          appBar: AppBar(
            title: Text(title),
          ),
          body: GridView.builder(
            itemBuilder: (context, position) {
              Competition comp = competitions[position];
              int numberOfFollowers = comp.numOfFollowers;

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
                          Container(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "Followers: $numberOfFollowers",
                              style: TextStyle(fontSize: 16),
                            ),
                          )
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
