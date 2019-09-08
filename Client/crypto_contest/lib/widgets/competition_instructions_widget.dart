import 'package:crypto_contest/blocs/competition_instructions_bloc.dart';
import 'package:crypto_contest/database_schema/competition_details.dart';
import 'package:flutter/material.dart';

/// Display the instructions and instruction updates for the rules of the competition
class CompetitionInstructionsWidget extends StatefulWidget {
  final String competitionId;

  /// Constructor
  CompetitionInstructionsWidget(this.competitionId, {Key key}) : super(key: key);

  @override
  _CompetitionInstructionsWidgetState createState() => _CompetitionInstructionsWidgetState();
}

class _CompetitionInstructionsWidgetState extends State<CompetitionInstructionsWidget> {
  CompetitionInstructionsBloc _bloc;

  @override
  void initState() {
    _bloc = CompetitionInstructionsBloc(widget.competitionId);
    super.initState();
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<CompetitionDetails>(
      stream: _bloc.competitionDetails,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: const CircularProgressIndicator(),
          );
        }
        CompetitionDetails details = snapshot.data;
        return Container(
          color: const Color(0xffd9d9d9),
          child: ListView.builder(
            itemCount: details.creatorUpdates.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                // Header view
                return Column(
                  children: <Widget>[
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      "Instructions",
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Card(
                        color: Theme.of(context).chipTheme.selectedColor,
                        margin: const EdgeInsets.all(8.0),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            details.description,
                            textAlign: TextAlign.left,
                            style: const TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                    if (details.creatorUpdates.length > 0)
                      Text("Updates", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ],
                );
              }
              index -= 1;
              return Align(
                alignment: Alignment.centerLeft,
                child: Card(
                    color: Theme.of(context).chipTheme.selectedColor,
                    margin: const EdgeInsets.all(8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        details.creatorUpdates[index],
                        style: const TextStyle(fontSize: 18),
                      ),
                    )),
              );
            },
          ),
        );
      },
    );
  }
}
