import 'dart:ui' as ui;

import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

import 'lens.dart';

void main() {
  runApp(
    new MaterialApp(
      title: "Flutter Demo",
      routes: {
        '/': (RouteArguments args) => new Adapt()
      }
    )
  );
}

class Adapt extends StatefulComponent {
  AdaptState createState() => new AdaptState();
}

class FlexLens extends Lens {
  const FlexLens(this.direction, Key key) : super(key);
  final FlexDirection direction;
  Widget build(BuildContext context) {
    return new DecoratedBox(
      decoration: new BoxDecoration(backgroundColor: const Color(0xFF0000)),
      child: new Flex(
        <Widget>[
          new Text("Hello"),
          new Text("World")
        ],
        direction: direction,
        justifyContent: FlexJustifyContent.spaceAround
      )
    );
  }
}

Key horizontal = new ValueKey('horizontal');
Key vertical = new ValueKey('vertical');

class AdaptState extends State<Adapt> with LensSwitcher {

  FlexDirection _direction = FlexDirection.horizontal;
  Key _key = horizontal;

  Widget _buildContent(BuildContext context) {
    Size size = ui.window.size;
    _direction = size.width > size.height ?
      FlexDirection.horizontal :
      FlexDirection.vertical;
    _key = size.width > size.height ?
      horizontal :
      vertical;
    return new Applique(new FlexLens(_direction, _key), this);
  }

  TransitionComponent switchLenses(Lens from, Lens to, PerformanceView performance) {
    final Color begin = (to.key == vertical) ? const Color(0xFFFFAABB) : const Color(0xFFAAFFBB);
    final Color end = (to.key == vertical) ? const Color(0xFFAAFFBB) : const Color(0xFFFFAABB);
    final AnimatedColorValue animatedColor = new AnimatedColorValue(begin, end: end, curve: new Linear());
    return new ColorTransition(color: animatedColor, performance: performance, child: to);
  }

  Widget build(BuildContext context) {
    return new Scaffold(
      toolBar: new ToolBar(
        center: new Text("Flutter Demo")
      ),
      body: new Material(
        child: _buildContent(context)
      )
    );
  }
}
