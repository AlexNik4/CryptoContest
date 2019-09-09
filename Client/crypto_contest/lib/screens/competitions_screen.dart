import 'package:crypto_contest/blocs/competitions_screen_bloc.dart';
import 'package:crypto_contest/database_schema/competition.dart';
import 'package:crypto_contest/managers/navigation_mgr.dart';
import 'package:crypto_contest/widgets/competition_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';

class CompetitionsScreen extends StatefulWidget {
  @override
  _CompetitionsScreenState createState() => _CompetitionsScreenState();
}

class _CompetitionsScreenState extends State<CompetitionsScreen> with WidgetsBindingObserver {
  final _title = "Competitions";
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
    int gridCount = (MediaQuery.of(context).size.width / 180).floor();
    if (gridCount == 0) {
      gridCount = 1;
    }

    return Scaffold(
      backgroundColor: const Color(0xffe6e6e6),
      appBar: AppBar(
        title: Text(_title),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.person_pin,
              size: 28,
            ),
            // TODO : Alex - Put this in the app bar class?
            onPressed: GetIt.I.get<NavigationMgr>().navigateToUserDetailsScreen,
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _bloc.createNewCompetition,
        tooltip: 'Create Contest',
        child: const Icon(Icons.add),
      ), // T
      body: StreamBuilder<List<Competition>>(
        stream: _bloc.competitionsStream,
        builder: (BuildContext context, AsyncSnapshot<List<Competition>> snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
              itemBuilder: (context, position) {
                return CompetitionItemWidget(snapshot.data[position], useHero: true);
              },
              itemCount: snapshot.data.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: gridCount),
            );
          } else {
            return Center(child: const CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
