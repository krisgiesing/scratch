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

/// Generated code: Template
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

/// Generated code: Lens definitions (styles)
LensState horizontal = new LensState('horizontal', {
  'color': const Color(0xFFFFAABB),
  'direction': FlexDirection.horizontal
});

LensState vertical = new LensState('vertical', {
  'color': const Color(0xFFAAFFBB),
  'direction': FlexDirection.vertical
});

LensTransitionSpec swapper = new LensTransitionSpec(
  duration: const Duration(milliseconds: 500),
  animatedProperties: [ 'color' ]
);

LensTransitionMap transitions = new LensTransitionMap({
  'horizontal' : {
    'vertical' : swapper
  },
  'vertical' : {
    'horizontal' : swapper
  }
});

/// Generated code: Lens application
/// TODO: This needs other bindings to input and output
/// Generated code: controller?
Widget flexComponentFromLens(Lens lens, BuildContext context) {
  return new FlexComponent(direction: lens["direction"], color: lens["color"]);
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
        child: new Applique(_lens, transitions, flexComponentFromLens)
      )
    );
  }
}
