import 'dart:math';

import 'package:flutter/material.dart';

class ShakeAnimationWidget extends StatefulWidget {
  final Widget child;

  const ShakeAnimationWidget({Key key, @required this.child}) : super(key: key);

  @override
  ShakeAnimationWidgetState createState() => ShakeAnimationWidgetState();
}

class ShakeAnimationWidgetState extends State<ShakeAnimationWidget>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _controller.addListener(() => setState(() {}));
  }

  Future<void> startAnimation() async {
    try {
      _controller.reset();
      await _controller.forward();
    } on TickerCanceled {
      // the animation got canceled, probably because we were disposed
    }
  }

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(sin(_controller.value * pi * 8) * 4, 0),
      child: widget.child,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
