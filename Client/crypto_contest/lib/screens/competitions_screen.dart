import 'package:crypto_contest/blocs/competitions_screen_bloc.dart';
import 'package:crypto_contest/database_schema/competition.dart';
import 'package:crypto_contest/views/competition_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CompetitionsScreen extends StatefulWidget {
  @override
  _CompetitionsScreenState createState() => _CompetitionsScreenState();
}

class _CompetitionsScreenState extends State<CompetitionsScreen> with WidgetsBindingObserver {
  CompetitionsScreenBloc _bloc;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);
    _bloc = CompetitionsScreenBloc();
    _bloc.loadCompetitions();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _bloc.loadCompetitions();
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() {
    super.dispose();

    WidgetsBinding.instance.removeObserver(this);
    _bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final title = 'Competitions';

    return MaterialApp(
      title: title,
      home: Scaffold(
        backgroundColor: const Color(0xffe6e6e6),
        appBar: AppBar(
          title: Text(title),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _bloc.createNewCompetition(),
          tooltip: 'Create Contest',
          child: const Icon(Icons.add),
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
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              );
            } else {
              return Center(child: const CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
