import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import 'lens.dart';

import 'generated/lenses.dart';
import 'generated/overlays.dart';

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

/// Application code
class Adapt extends StatefulComponent {
  AdaptState createState() => new AdaptState();
}

class AdaptState extends State<Adapt> with BindingObserver {

  AdaptState() {
    WidgetFlutterBinding.instance.addObserver(this);
  }

  LensState _lens = vertical;
  String _first = ui.window.size.width.toString();
  String _second = ui.window.size.height.toString();

  void didChangeSize(Size size) {
    setState(() {
      _lens = size.width > size.height ? horizontal : vertical;
      _first = size.width.toString();
      _second = size.height.toString();
    });
  }

  void toggle() {
    setState(() {
      _lens = _lens == horizontal ? vertical : horizontal;
    });
  }

  Widget build(BuildContext context) {
    return new Scaffold(
      toolBar: new ToolBar(
        center: new Text("Flutter Demo")
      ),
      body: new Material(
        child: new GestureDetector(
          child: new Applique(_lens, transitions, this.buildWithLens),
          onTap: this.toggle
        )
      )
    );
  }

  Widget buildWithLens(Lens lens, BuildContext context) {
    return gridComponentOverlay(lens, context, _first, _second);
  }
}
