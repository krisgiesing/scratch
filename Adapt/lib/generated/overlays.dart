import 'package:flutter/widgets.dart';

import '../lens.dart';

import 'templates.dart';

/// Generated code: Lens application
/// Note slots hoisted from generated widget's input parameters
Widget flexComponentOverlay(Lens lens, BuildContext context, String first, String second) {
  return new FlexComponent(
    direction: lens["direction"],
    color: lens["color"],
    progress: lens["lens:layout"],
    first: first,
    second: second
  );
}

/// Generated code: Lens application
/// Note slots hoisted from generated widget's input parameters
Widget gridComponentOverlay(Lens lens, BuildContext context, String first, String second) {
  return new GridComponent(
    direction: lens["direction"],
    color: lens["color"],
    progress: lens["lens:layout"],
    first: first,
    second: second
  );
}
