import 'package:crypto_contest/blocs/competitions_screen_bloc.dart';
import 'package:crypto_contest/models/competition.dart';
import 'package:crypto_contest/views/competition_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CompetitionsScreen extends StatefulWidget {
  @override
  _CompetitionsScreenState createState() => _CompetitionsScreenState();
}

class _CompetitionsScreenState extends State<CompetitionsScreen> {
  final CompetitionsScreenBloc _bloc = CompetitionsScreenBloc();

  @override
  void initState() {
    super.initState();

    _bloc.start();
  }

  @override
  void dispose() {
    super.dispose();

    _bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final title = 'Competitions';

    return MaterialApp(
      title: title,
      home: Scaffold(
        backgroundColor: Color(0xffe6e6e6),
        appBar: AppBar(
          title: Text(title),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _bloc.createNewCompetition(),
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ), // T
        body: StreamBuilder<List<Competition>>(
          stream: _bloc.competitionsStream,
          builder: (BuildContext context, AsyncSnapshot<List<Competition>> snapshot) {
            if (snapshot.hasData) {
              return GridView.builder(
                itemBuilder: (context, position) {
                  return CompetitionItemWidget(snapshot.data[position]);
                },
                itemCount: snapshot.data.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
