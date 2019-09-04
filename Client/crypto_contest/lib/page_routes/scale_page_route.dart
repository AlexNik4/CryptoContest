import 'package:flutter/material.dart';

/// Navigation type that scales up from a given location
class ScalePageRoute extends PageRouteBuilder {
  final Widget widget;
  final Alignment scaleStartLocation;

  /// Constructor
  ScalePageRoute({this.widget, this.scaleStartLocation = Alignment.center})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              widget,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              ScaleTransition(
            alignment: scaleStartLocation,
            scale: Tween<double>(
              begin: 0.0,
              end: 1.0,
            ).animate(
              CurvedAnimation(
                parent: animation,
                curve: Curves.fastOutSlowIn,
              ),
            ),
            child: child,
          ),
        );
}
