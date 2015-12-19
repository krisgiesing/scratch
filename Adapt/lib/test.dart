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

  Widget build(BuildContext context) {
    final Color bgColor = const Color(0xFF774444);
    return new Scaffold(
      toolBar: new ToolBar(
        center: new Text("Flutter Demo")
      ),
      body: new DecoratedBox(
        decoration: new BoxDecoration(
          backgroundColor: bgColor,
          border: new Border.all(width: 10.0, color: bgColor)
        ),
        child: new Center(child: new Text("Hello World"))
      )
    );
  }

}
