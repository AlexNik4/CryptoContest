import 'package:crypto_contest/database_schema/competition.dart';
import 'package:crypto_contest/managers/navigation_mgr.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';

/// Widget that displays a single competition as a list item
class CompetitionItemWidget extends StatelessWidget {
  final Competition _competition;
  final GlobalKey _key = GlobalKey();

  final bool useHero;

  /// Constructor
  CompetitionItemWidget(this._competition, {Key key, this.useHero = false}) : super(key: key);

  Alignment _getAlignedLocation(BuildContext context) {
    final RenderBox renderBox = _key.currentContext.findRenderObject();
    final widgetPosition = renderBox.localToGlobal(Offset.zero);
    final screenSize = MediaQuery.of(context).size;

    final screenCenterX = screenSize.width / 2;
    final screenCenterY = screenSize.height / 2;
    final widgetCenterX = widgetPosition.dx + renderBox.size.width / 2;
    final widgetCenterY = widgetPosition.dy + renderBox.size.height / 2;

    double xAlignment = (widgetCenterX - screenCenterX) / screenCenterX;
    double yAlignment = (widgetCenterY - screenCenterY) / screenCenterY;

    return Alignment(xAlignment, yAlignment);
  }

  @override
  Widget build(BuildContext context) {
    var primaryBody = Card(
      child: Stack(children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(3.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Text(
                      _competition.creatorDisplayName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Expanded(
                    flex: 0,
                    child: const SizedBox(),
                  ),
                  Text(
                    _competition.prizeValue.toString(),
                    style: const TextStyle(
                        color: Colors.green, fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                  Text(_competition.coinSymbol)
                ],
              ),
              Text(
                _competition.title,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
                const Icon(
                  Icons.group,
                  color: Colors.blueAccent,
                  size: 19,
                ),
                Text(
                  _competition.followerCount.toString(),
                  style: const TextStyle(fontSize: 16),
                ),
              ])
            ],
          ),
        ),
        Positioned.fill(
            child: Material(
                color: Colors.transparent,
                child: InkWell(
                  highlightColor: const Color(0x44ff9933),
                  splashColor: const Color(0x44ff8000),
                  onTap: () {
                    GetIt.I.get<NavigationMgr>().navigateToCompetitionDetailsScreen(_competition,
                        animationStartAlignment: _getAlignedLocation(context));
                  },
                )))
      ]),
    );

    Widget _getParentWidget() {
      if (useHero) {
        return Hero(key: _key, tag: _competition.id, child: primaryBody);
      }
      return primaryBody;
    }

    // Main build method
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: _getParentWidget(),
    );
  }
}
