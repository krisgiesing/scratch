import 'package:flutter/material.dart';

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

class AdaptState extends State<Adapt> {

  FlexDirection _direction = FlexDirection.horizontal;

  void _handleSizeChanged(Size newSize) {
    setState(() {
      _direction = newSize.width > newSize.height ?
        FlexDirection.horizontal :
        FlexDirection.vertical;
    });
  }

  Widget _buildContent(BuildContext context) {
    return new Flex(
      <Widget>[
        new Text("Hello"),
        new Text("World")
      ],
      direction: _direction,
      justifyContent: FlexJustifyContent.spaceAround
    );
  }

  Widget build(BuildContext context) {
    return new Scaffold(
      toolBar: new ToolBar(
        center: new Text("Flutter Demo")
      ),
      body: new SizeObserver(
        child: new Material(
          child: _buildContent(context)
        ),
        onSizeChanged: _handleSizeChanged
      )
    );
  }
}
