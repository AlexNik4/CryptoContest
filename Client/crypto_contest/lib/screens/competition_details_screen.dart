import 'package:crypto_contest/database_schema/competition.dart';
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

  @override
  void initState() {
    _tabController = TabController(vsync: this, length: 2);
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    // "Unmount" the controllers:
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double toolbarHeight = kToolbarHeight - 10;

    return Container(
      color: Theme.of(context).primaryColor,
      child: SafeArea(
        child: Scaffold(
          body: NestedScrollView(
            controller: _scrollController,
            headerSliverBuilder: (BuildContext context, bool innerViewIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  expandedHeight: 200,
                  flexibleSpace: FlexibleSpaceBar(
                    collapseMode: CollapseMode.pin,
                    background: Column(
                      children: <Widget>[
                        Expanded(
                          child: ConstrainedBox(
                              constraints: BoxConstraints(minHeight: 200 - toolbarHeight),
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
                Container(
                  child: ListView.builder(
                    itemCount: 100,
                    itemBuilder: (BuildContext context, int index) {
                      return Text(index.toString());
                    },
                  ),
                ),
                Container(
                  color: Colors.blue,
                ),
              ],
              controller: _tabController,
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => null,
            child: Icon(
              Icons.add_box,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
