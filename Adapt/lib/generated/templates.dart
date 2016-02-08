import 'package:flutter/widgets.dart';

import '../layout_animator.dart';

/// Generated from template 'FlexComponent'
class FlexComponent extends StatelessComponent {
  const FlexComponent({ this.direction, this.color, this.first, this.second, this.progress, Key key }) : super(key: key);
  final FlexDirection direction;
  final Color color;
  final String first;
  final String second;
  final double progress;
  Widget build(BuildContext context) {
    return new DecoratedBox(
      decoration: new BoxDecoration(backgroundColor: color),
      child: new LayoutAnimator(
        child: new Flex(
          children: <Widget>[
            new Text(first),
            new Text(second)
          ],
          direction: direction,
          justifyContent: FlexJustifyContent.spaceAround
        ),
        progress: progress
      )
    );
  }
}

class GridComponent extends StatelessComponent {
  const GridComponent({ this.direction, this.color, this.first, this.second, this.progress, Key key }) : super(key: key);
  final FlexDirection direction;
  final Color color;
  final String first;
  final String second;
  final double progress;
  Widget build(BuildContext context) {
    return new DecoratedBox(
      decoration: new BoxDecoration(backgroundColor: color),
      child: new LayoutAnimator(
        child: new FixedColumnCountGrid(
          children: <Widget>[
            new Text(first),
            new Text(second)
          ],
          columnCount: this.direction == FlexDirection.horizontal ? 1 : 2,
          padding: const EdgeDims.all(12.0)
        ),
        progress: progress
      )
    );
  }
}
