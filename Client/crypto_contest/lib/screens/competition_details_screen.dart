import 'package:crypto_contest/blocs/competition_details_screen_bloc.dart';
import 'package:crypto_contest/database_schema/competition.dart';
import 'package:crypto_contest/widgets/competition_contestants_widget.dart';
import 'package:crypto_contest/widgets/competition_instructions_widget.dart';
import 'package:crypto_contest/widgets/competition_item_widget.dart';
import 'package:flutter/material.dart';

/// Displays the details for a single competition
class CompetitionDetailsScreen extends StatefulWidget {
  final Competition competition;

  /// Constructor
  CompetitionDetailsScreen(this.competition);

  @override
  _CompetitionDetailsScreenState createState() => _CompetitionDetailsScreenState();
}

class _CompetitionDetailsScreenState extends State<CompetitionDetailsScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  ScrollController _scrollController;
  CompetitionDetailsScreenBloc _bloc;

  @override
  void initState() {
    _bloc = CompetitionDetailsScreenBloc(widget.competition);
    _tabController = TabController(vsync: this, length: 2);
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _bloc.dispose();
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double toolbarHeight = kToolbarHeight - 10;
    final double topSliverHeight = 200;

    return Container(
      color: Theme.of(context).primaryColor,
      child: SafeArea(
        child: Scaffold(
          body: NestedScrollView(
            controller: _scrollController,
            headerSliverBuilder: (BuildContext context, bool innerViewIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  iconTheme: IconThemeData(color: Colors.black),
                  expandedHeight: topSliverHeight,
                  flexibleSpace: FlexibleSpaceBar(
                    collapseMode: CollapseMode.pin,
                    background: Column(
                      children: <Widget>[
                        Expanded(
                          child: ConstrainedBox(
                              constraints:
                                  BoxConstraints(minHeight: topSliverHeight - toolbarHeight),
                              child:
                                  AbsorbPointer(child: CompetitionItemWidget(widget.competition))),
                        ),
                        SizedBox(
                          height: toolbarHeight,
                        ),
                      ],
                    ),
                  ),
                  pinned: true,
                  floating: true,
                  forceElevated: innerViewIsScrolled,
                  bottom: TabBar(
                    indicatorColor: Colors.white,
                    indicatorWeight: 4,
                    indicatorSize: TabBarIndicatorSize.label,
                    tabs: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.info,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 5,
                            height: toolbarHeight,
                          ),
                          Text("Details", style: TextStyle(color: Colors.white))
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.people,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 5,
                            height: toolbarHeight,
                          ),
                          Text("Contestants", style: TextStyle(color: Colors.white))
                        ],
                      ),
                    ],
                    controller: _tabController,
                  ),
                )
              ];
            },
            body: TabBarView(
              children: <Widget>[
                CompetitionInstructionsWidget(widget.competition),
                CompetitionContestantsWidget(widget.competition),
              ],
              controller: _tabController,
            ),
          ),
          floatingActionButton: StreamBuilder<bool>(
              stream: _bloc.isCompetitionCreator,
              initialData: _bloc.isCompetitionCreator.value,
              builder: (context, snapshot) {
                if (snapshot.data) {
                  return SizedBox();
                }
                return FloatingActionButton(
                  onPressed: _bloc.enterCompetition,
                  child: Icon(
                    Icons.add_box,
                    color: Colors.white,
                  ),
                );
              }),
        ),
      ),
    );
  }
}
