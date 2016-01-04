import 'dart:ui' as ui;

import 'package:flutter/animation.dart';
import 'package:flutter/rendering.dart';
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

class FlexComponent extends StatelessComponent {
  const FlexComponent({ this.direction, this.color, Key key }) : super(key: key);
  final FlexDirection direction;
  final Color color;
  Widget build(BuildContext context) {
    return new DecoratedBox(
      decoration: new BoxDecoration(backgroundColor: color),
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

LensState horizontal = new LensState('horizontal', {
  'color': const Color(0xFFFFAABB),
  'direction': FlexDirection.horizontal
});

LensState vertical = new LensState('vertical', {
  'color': const Color(0xFFAAFFBB),
  'direction': FlexDirection.vertical
});

class Adapt extends StatefulComponent {
  AdaptState createState() => new AdaptState();
}

class AdaptState extends State<Adapt> with BindingObserver {

  AdaptState() {
    FlutterBinding.instance.addObserver(this);
  }

  LensState _lens = horizontal;

  void didChangeSize(Size size) {
    setState(() {
      _lens = size.width > size.height ? horizontal : vertical;
    });
  }

  Widget build(BuildContext context) {
    return new Scaffold(
      toolBar: new ToolBar(
        center: new Text("Flutter Demo")
      ),
      body: new Material(
        child: new Applique(_lens, this.switchLenses, this.buildWithLens)
      )
    );
  }

  Performance switchLenses(Lens from, Lens to, LensTransition transition) {
    if (from != null) {
      transition.animations["color"] = new AnimatedColorValue(from.get("color"), end: to.get("color"));
      return new Performance(duration: new Duration(milliseconds: 500));
    } else {
      return null;
    }
  }

  Widget buildWithLens(Lens lens, BuildContext context) {
    return new FlexComponent(direction: lens.get("direction"), color: lens.get("color"));
  }
}
