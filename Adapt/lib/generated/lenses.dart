import 'package:flutter/widgets.dart';

import '../lens.dart';

/// Generated code: Lens definitions (styles)
LensState horizontal = new LensState('horizontal', {
  'color': const Color(0xFFFFAABB),
  'direction': FlexDirection.horizontal
});

LensState vertical = new LensState('vertical', {
  'color': const Color(0xFFAAFFBB),
  'direction': FlexDirection.vertical
});

LensState unattached = new LensState(null, {
  'color': const Color(0xFFAABBFF)
});

LensTransitionSpec swapper = new LensTransitionSpec(
  duration: const Duration(milliseconds: 500),
  animatedProperties: [ 'color', 'lens:layout' ]
);

LensTransitionSpec opener = new LensTransitionSpec(
  duration: const Duration(milliseconds: 3000),
  animatedProperties: [ 'color' ]
);

LensTransitionMap transitions = new LensTransitionMap({
  'horizontal' : {
    'vertical' : swapper
  },
  'vertical' : {
    'horizontal' : swapper
  },
  null : {
    'horizontal' : opener,
    'vertical' : opener
  }
});
