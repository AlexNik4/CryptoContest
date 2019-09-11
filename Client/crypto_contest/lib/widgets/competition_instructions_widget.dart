import 'package:crypto_contest/blocs/competition_instructions_bloc.dart';
import 'package:crypto_contest/database_schema/competition.dart';
import 'package:crypto_contest/database_schema/competition_details.dart';
import 'package:flutter/material.dart';

/// Display the instructions and instruction updates for the rules of the competition
class CompetitionInstructionsWidget extends StatefulWidget {
  final Competition competition;

  /// Constructor
  CompetitionInstructionsWidget(this.competition, {Key key}) : super(key: key);

  @override
  _CompetitionInstructionsWidgetState createState() => _CompetitionInstructionsWidgetState();
}

class _CompetitionInstructionsWidgetState extends State<CompetitionInstructionsWidget> {
  CompetitionInstructionsBloc _bloc;

  @override
  void initState() {
    _bloc = CompetitionInstructionsBloc(widget.competition);
    super.initState();
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Show update dialog
    Future<void> _showUpdateDialog() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Create Update'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  TextFormField(
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minWidth: 60),
                  child: Center(
                    child: Text(
                      'Discard',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              RaisedButton(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minWidth: 80),
                  child: Center(
                    child: Text(
                      'Update',
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    // Create the header for the instruction list
    Widget _createHeaderView(String description) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
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
                child: SelectableText(
                  description,
                  textAlign: TextAlign.left,
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ),
          ),
          Text("Updates", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      );
    }

    // Footer view for the instructions list
    var listFooterView = StreamBuilder<bool>(
        stream: _bloc.isCompetitionCreator,
        initialData: _bloc.isCompetitionCreator.value,
        builder: (context, snapshot) {
          if (snapshot.data) {
            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: <Widget>[
                  Spacer(),
                  ConstrainedBox(
                    constraints: BoxConstraints(minWidth: 80),
                    child: RaisedButton(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.add),
                          SizedBox(
                            width: 4,
                          ),
                          Text(
                            'Add Update',
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          ),
                        ],
                      ),
                      onPressed: _showUpdateDialog,
                    ),
                  ),
                  Spacer(),
                ],
              ),
            );
          }
          return SizedBox();
        });

    // Primary builder
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
            itemCount: details.creatorUpdates.length + 2,
            itemBuilder: (context, index) {
              if (index == 0) {
                // Header view
                return _createHeaderView(details.description);
              } else if (index == details.creatorUpdates.length + 1) {
                // Footer view
                return listFooterView;
              }

              index -= 1;
              return Align(
                alignment: Alignment.centerLeft,
                child: Card(
                    color: Theme.of(context).chipTheme.selectedColor,
                    margin: const EdgeInsets.all(8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SelectableText(
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
